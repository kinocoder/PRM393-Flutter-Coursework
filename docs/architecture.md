# MVVM với Riverpod

## Quyết định hiện tại

Theo yêu cầu mới, Riverpod quản lý cả state và DI. Đã thay toàn bộ ChangeNotifier ViewModel/ListenableBuilder bằng Notifier/AsyncNotifier và ConsumerWidget. Repository vẫn dùng ChangeNotifier để thông báo thay đổi dữ liệu nội bộ; UI không nghe repository trực tiếp.

Tài liệu đã đối chiếu:
- [Flutter Compass](https://docs.flutter.dev/app-architecture/case-study)
- [Riverpod refs: watch, read, listen](https://riverpod.dev/docs/concepts2/refs)
- [Riverpod families](https://riverpod.dev/docs/concepts2/family)

## Trách nhiệm các lớp

| Lớp | Trách nhiệm |
|---|---|
| View | ref.watch để hiển thị state; ref.read(provider.notifier) để gửi sự kiện; ref.listen để hiện SnackBar. Không gọi repository/service |
| ViewModel | Notifier/AsyncNotifier, quản lý state bất biến và thao tác; ref.watch repository dependency trong build; không có BuildContext/widget |
| Repository | Nguồn dữ liệu thống nhất, cache riêng tư, validation và mutation; thông báo thay đổi dữ liệu |
| Service | Đọc asset JSON; có thể thay bằng nguồn ngoài khác |
| Model | Dữ liệu bất biến và chuyển đổi JSON, không có UI |

Service và repository nhận dependency qua constructor. ViewModel do Riverpod tạo và nhận dependency qua Ref trong build, thay cho constructor injection trước đây. Override provider cho phép inject fake khi kiểm thử.

## File và chức năng

| File | Vai trò |
|---|---|
| lib/app/dependencies.dart | Chỉ chứa provider Service/Repository, dùng chung trong ProviderScope |
| lib/utils/async_repository_view_model.dart | FeatureState bất biến; nối listener repository với state Riverpod; chống mutation lặp và completion cũ |
| lib/features/cart/viewmodel/cart_view_model.dart | cartViewModelProvider, AsyncNotifier và các thao tác giỏ |
| lib/features/cart/viewmodel/cart_state.dart | Danh sách, trạng thái chọn, tổng tiền hiển thị |
| lib/features/cart/view/cart_view.dart | Watch trạng thái giỏ, listen lỗi thao tác, hiển thị loading/error/empty/data |
| lib/features/products/viewmodel/products_view_model.dart | Danh sách, từ khóa tìm kiếm và CRUD |
| lib/features/products/viewmodel/product_detail_view_model.dart | AsyncNotifier family theo Product; state thao tác thêm giỏ |
| lib/features/products/view/ | View danh sách/chi tiết quan sát provider; widget card vẫn là widget trình bày |
| lib/features/classroom/viewmodel/classroom_view_model.dart | Danh sách bài học, state nút thích bất biến |
| lib/features/classroom/view/ | Giao diện phản ứng với state Riverpod |
| lib/features/ui_exercises/viewmodel/ | Notifier đồng bộ cho counter, theme, input controls |
| lib/features/ui_exercises/view/ | ConsumerWidget; bỏ tự tạo/dispose ViewModel và ListenableBuilder |
| lib/data/repositories/cart_repository.dart | Vẫn sở hữu dữ liệu giỏ; bổ sung chú thích phân biệt provider repository với provider state |
| lib/app/views/ | Ghép các feature; không truyền instance ViewModel như trước |
| test/features/ | ProviderContainer, override repository/service, kiểm thử state và lifecycle |
| README.md, docs/architecture.md | Hướng dẫn kiến trúc hiện tại |

Đã bỏ utils/command.dart, utils/command_view_model.dart và test Command cũ sau khi thay bằng thao tác Notifier và kiểm thử tương ứng. Không thêm package, annotation hoặc codegen.

## Luồng dữ liệu

```text
View --read(provider.notifier).action()--> ViewModel
ViewModel --> Repository --> Service (khi cần tải dữ liệu)
Repository --thông báo thay đổi--> ViewModel --state mới--> Riverpod
Riverpod --ref.watch--> View dựng lại
Riverpod --ref.listen--> SnackBar của View
```

Ví dụ thêm giỏ:
1. ProductDetailView gọi addToCart trên notifier của productDetailViewModelProvider(product).
2. Notifier đặt AsyncLoading, gọi CartRepository.addProduct.
3. Repository khởi tạo từ Service nếu cần, rồi cập nhật cache và thông báo.
4. CartViewModel đang nghe repository chụp CartState mới và gán AsyncData.
5. Mọi consumer của cartViewModelProvider nhận dữ liệu mới, kể cả consumer ở màn hình khác.
6. Provider chi tiết chuyển AsyncData(true) hoặc AsyncError. View hiện SnackBar qua ref.listen, không lặp thông báo chỉ vì rebuild.

Nếu giỏ chưa từng được xem, lần build đầu của cartViewModelProvider đọc cache hiện tại, vẫn thấy sản phẩm vừa thêm. Không có ViewModel gọi một ViewModel khác.

## Trạng thái và thao tác bất đồng bộ

AsyncRepositoryViewModel<T> dùng AsyncValue<FeatureState<T>>:
- AsyncLoading: đang tải.
- AsyncError: tải thất bại, nút thử lại invalidate provider.
- AsyncData: dữ liệu dùng để hiển thị; danh sách rỗng là trạng thái empty.
- FeatureState.isBusy: đang mutation; UI khóa thao tác và giữ danh sách.
- FeatureState.actionError: lỗi mutation; dữ liệu hợp lệ trước đó được giữ lại.
- Mutation thành công trả true, hết busy và xóa lỗi cũ.

Các phương thức Notifier thay cho đối tượng Command ChangeNotifier trước đây. Chúng vẫn bảo đảm chạy một mutation tại một thời điểm trên cùng ViewModel, báo trạng thái và giữ dữ liệu khi lỗi. Không dùng API mutation experimental.

Provider chi tiết dùng AsyncValue<bool>: false là chưa thao tác, loading là đang thêm, true là thành công, error là thất bại. Gọi lặp khi loading bị bỏ qua.

## Lifetime và đồng bộ

- Repository và state danh sách/giỏ/bài học sống trong ProviderScope, giữ trạng thái khi chuyển tab.
- Hai ProviderScope độc lập không chia sẻ dữ liệu ngoài ý muốn.
- Chi tiết dùng family autoDispose theo Product bất biến; các bài tập dùng NotifierProvider.autoDispose, reset khi rời trang.
- Listener repository được tháo bằng ref.onDispose.
- Generation token và ref.mounted ngăn completion của tác vụ cũ ghi đè provider đã rebuild/dispose. Tác vụ dữ liệu đã bắt đầu không bị hủy: nếu repository còn được dùng, kết quả hợp lệ vẫn được thông báo đến state mới.
- Retry tải ban đầu là thủ công, tắt automatic retry cho các provider dữ liệu để UI giữ lỗi đến khi người dùng thử lại.
- Invalidate ViewModel không nạp lại seed và xóa giỏ: repository vẫn giữ cache trong phiên.
- State điều hướng/tab trong app có thể dùng setState vì đây là trạng thái điều hướng cục bộ.

## Phạm vi dữ liệu giữ nguyên

Service đọc asserts/data/shop.json. Các thao tác thêm/sửa/xóa chỉ cập nhật repository trong RAM; chưa có API hoặc lưu database. Model và repository dùng chung nằm ngoài feature. Bài học UI và ví dụ people được giữ lại.

## Khác Compass

- Dùng Riverpod Notifier/AsyncNotifier thay ChangeNotifier/ListenableBuilder cho UI theo yêu cầu mới; Ref thay constructor injection riêng cho ViewModel.
- Vẫn giữ MVVM và phân tách Repository/Service; repository notification là chi tiết data layer.
- Command object cũ được thay bằng phương thức Notifier và state thao tác bất biến.
- Service asset thay HTTP, model viết tay thay Freezed, Navigator thay go_router, không thêm use-case layer hoặc môi trường staging vì dự án chưa cần.
- Cấu trúc feature, dữ liệu và các hành vi cũ được giữ lại.

## Kiểm thử

```powershell
flutter analyze
flutter test
```

Kiểm thử gồm dữ liệu asset/JSON, cache/CRUD, loading/error/retry/empty, tìm kiếm, state bất biến, thêm giỏ từ chi tiết, hai consumer quan sát cùng giỏ, scope độc lập, state sau invalidation, chống lặp mutation, dispose/rebuild khi tác vụ chưa xong, các Notifier bài tập và luồng mua hàng trên widget.

Chưa chạy thủ công trên thiết bị Android/iOS thật.
