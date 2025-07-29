# rete-homepage

## Project setup

```
npm install
```

### Compiles and hot-reloads for development

```
npm run dev
```

### Compiles and minifies for production

```
npm run generate
```

### Deploy to GitHub Pages

Các thư mục build product ở trên không được commit lên repo, mà sẽ được build tự động thông qua GitHub Actions lên GitHub Pages. Do đó, bạn cần cấu hình GitHub Actions để tự động build và deploy trang web của bạn.
**Checkout tại `<nhánh sẽ deploy>`**

#### Cách 1 (tự động)

IMPORTANT: TÊN THƯ MỤC DỰ ÁN TRÊN MÁY PHẢI TRÙNG VỚI TÊN REPO ĐỂ TẠO SYMLINK CHO ĐÚNG.

1. Vào repo của bạn tại github, chọn `Settings` > `Pages`.
2. Chọn Source `Github Actions` trong mục `Build and deployment`.
3. Clear Cache của GitActions bằng cách vào `Actions` > `Cache` (nút này sẽ hiện ra khi bạn đã có ít nhất 1 lần chạy GitActions). Xóa các Cache nếu có.
4. Kiểm tra file `/.github/workflows/nuxtjs.yml`:

- Chọn nhánh sẽ deploy trong đoạn `branches: ["<nhánh sẽ deploy>"]`
- Kiểm tra lại đoạn `path: ./dist`. File này là symlink đến thư mục sau build.
  - Có thể kiểm tra thử xem nó có hoạt động đúng không bằng cách build thử trên máy local với lệnh `npm run generate`
  - Chạy lệnh `ls -l -a` tại thư mục gốc, xem nó có và trỏ tới thư mục đầu ra của `npm run generate` không? Ví dụ `.output/public`. Đây là thư mục chứa các file tĩnh đã được build.
- Nếu có lỗi xóa hết thư mục `.nuxt`, `.output`, `dist` và chạy lại lệnh `npm run generate` để tạo lại các thư mục này để kiểm tra.

5. Commit và push lên repo của bạn. GitHub Actions sẽ tự động build và deploy theo cấu hình của file `nuxtjs.yml` ở trên lên GitHub Pages.

#### Cách 2 (chỉnh sửa thủ công)

Không dùng symlink `./dist` nữa

1. Sửa `nuxt.config.ts` thêm `baseURL` như sau:

```ts
app: {
    baseURL: '/<yourresponame>/',
    },

```

- Chú ý thay `<yourresponame>` bằng tên repo của bạn, ví dụ: `learnretejs`. Hạn chế đặt tên có dấu hoặc ký tự đặc biệt.
- INPORTANT: Nên xóa Cache của GitActions(TRƯỚC KHI COMMIT) mỗi lần đổi tên repo hay thay đổi `baseURL` để tránh lỗi không tìm thấy trang ở bước Artifact.

2. Sau đó kiểm tra kết quả build `npm run generate` trên máy local như sau:

```
ℹ Prerendered 1080 routes in 36.317 seconds                                                                                                            nitro 10:57:34 PM
✔ Generated public .output/public                                                                                                                      nitro 10:57:34 PM
✔ You can preview this build using npx serve .output/public                                                                                            nitro 10:57:34 PM
✔ You can now deploy .output/public to any static hosting!                                                                                              nuxi 10:57:34 PM
```

3. Sửa `/.github/workflows/nuxtjs.yml` đoạn `path` dẫn về đúng thư mục sau khi build phía trên bước 2:

```yaml
- name: Upload artifact
  uses: actions/upload-pages-artifact@v3
  with:
    name: github-pages
    path: ./.output/public/
```

- Sẵn tiện kiểm tra lại nhánh deploy trong file này đoạn đầu `branches: ["<nhánh sẽ deploy>"]`

4. Commit và push lên repo của bạn.

- Kiểm tra lại GitPages đã chọn deploy bằng `Github actions`.
- INPORTANT nên lặp lại: Nên xóa Cache của GitActions(TRƯỚC KHI COMMIT) mỗi lần đổi tên repo hay thay đổi `baseURL` để tránh lỗi không tìm thấy trang ở bước Artifact.
- Tiến hành Commit và Push lên repo . Việc còn lại là của GitHub Actions sẽ tự động build và deploy lên GitHub Pages.
