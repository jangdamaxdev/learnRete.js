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

Checkout tại `<nhánh sẽ deploy>`

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
