# hoc_tren_truong

Ứng dụng Flutter theo **MVVM + Riverpod**: Riverpod quản lý cả trạng thái UI và dependency injection.

## Cấu trúc

```text
lib/
  main.dart                    # ProviderScope
  app/                         # DI repository/service, trang ghép và điều hướng
  models/                      # Product, CartItem bất biến
  data/repositories/           # Dữ liệu dùng chung, cache và quy tắc cập nhật
  data/services/               # Đọc dữ liệu mẫu từ asset
  features/
    products/view/             # ConsumerWidget dùng ref.watch/ref.listen
    products/viewmodel/        # AsyncNotifier: danh sách, thêm giỏ ở chi tiết
    cart/view/                 # CartView
    cart/viewmodel/            # AsyncNotifier + CartState
    classroom/                 # AsyncNotifier + View bài học
    ui_exercises/              # Notifier: counter, theme, input controls
    people/model/              # Ví dụ OOP có sẵn
  utils/async_repository_view_model.dart
asserts/data/shop.json          # Dữ liệu mẫu giữ nguyên
test/                          # Repository, service, provider, widget
```

## Cách dùng state giỏ hàng

Trong ConsumerWidget:

```dart
final cart = ref.watch(cartViewModelProvider);

// Trong callback:
ref.read(cartViewModelProvider.notifier).increaseQuantity(productId);
```

cartViewModelProvider trả AsyncValue<FeatureState<CartState>>:
- AsyncLoading / AsyncError: tải dữ liệu ban đầu và thử lại.
- AsyncData: value.data chứa CartState bất biến.
- value.isBusy / value.actionError: trạng thái thao tác, giữ dữ liệu hiện tại khi lỗi.

cartRepositoryProvider chỉ chia sẻ repository. Để UI tự rebuild khi giỏ đổi, luôn watch cartViewModelProvider. Thêm giỏ từ màn hình chi tiết sẽ tự phát state mới đến mọi consumer đang nghe giỏ, không cần invalidate thủ công.

## Chạy và kiểm tra

```powershell
flutter pub get
flutter run
flutter analyze
flutter test
```

Không cần build_runner. Dữ liệu chỉnh sửa vẫn chỉ lưu trong RAM.

Xem [docs/architecture.md](docs/architecture.md) để biết luồng MVVM, lifecycle, file đã sửa và các điểm khác Compass.
