---
description: Khám phá cách tối ưu hiệu năng trong các ứng dụng client. Tìm hiểu về việc giảm thiểu tác động của các thao tác đồng bộ và việc render trực tiếp các phần tử bởi trình duyệt
keywords: performance,optimization
---

# Performance

::references
:ref-example{title="Performance" link="/examples/performance"}
:ref-example{title="LOD" link="/examples/lod"}
:ref-example{title="LOD GPU" link="/examples/lod-gpu"}
::

Trong các ứng dụng client, bạn có thể thường xuyên gặp hai vấn đề: các thao tác tốn nhiều tài nguyên và FPS thấp. Vấn đề đầu tiên do các thao tác đồng bộ như thực thi JS nặng hoặc một số API của trình duyệt làm block main thread. Vấn đề thứ hai thường do trình duyệt render trực tiếp các phần tử – càng nhiều và càng phức tạp thì trình duyệt càng mất nhiều thời gian để tạo layout và render.

Trong bối cảnh framework này, bạn có thể áp dụng các cách tiếp cận sau để giảm thiểu tác động của các vấn đề trên:

## Chỉ kết nối plugin khi cần thiết {#connect-plugins}

Trong trường hợp chuyển đổi một đồ thị mà không cần trực quan hóa kết quả trung gian, có thể không cần kết nối thêm các plugin. Thay vào đó, hãy copy kết quả đã chuyển đổi sang một editor mới đã có sẵn các plugin cần thiết.

## Đơn giản hóa node ở một mức zoom nhất định {#simplify-at-zoom}

Kỹ thuật này đặc biệt hữu ích khi hiển thị số lượng lớn node. Trong các trường hợp như vậy, điểm nghẽn thường là trình duyệt render các phần tử khi tất cả node đều hiển thị trong viewport.

Thông thường, nếu nhiều node được hiển thị trong viewport, mức zoom sẽ khá thấp và mỗi node chỉ chiếm một vùng nhỏ. Do đó, các node này có thể được thay thế bằng các hình chữ nhật không có nội dung nhưng cùng kích thước, giúp giảm chi phí render mà vẫn giữ trải nghiệm người dùng tốt.

Kỹ thuật LOD (Level of Detail), thường dùng trong trực quan hóa 3D, cũng có thể áp dụng ở đây. Xem ví dụ [LOD](/examples/lod).
