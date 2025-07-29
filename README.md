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

### Deploy to GitHub Pages!

Các thư mục build product ở trên không được commit lên repo, mà sẽ được build tự động thông qua GitHub Actions, nén lại thành file dạng như `github-pages.zip` ở bước `Artifact` của `Deploy`, rồi đẩy lên GitHub Pages ở bước `Publish to GitHub Pages`. Do đó, bạn cần cấu hình GitHub Actions để tự động build và deploy trang web của bạn.

- Tại máy local **Checkout tại `<nhánh sẽ deploy>`**
- Do dùng Gitpages nên Github coi `https://<tên user>.github.io/` là `root` chung cho tất cả dự án, và trang chủ của bạn dự định deploy bắt đầu load từ `root/<tên repo>` tức là `https://<tên user>.github.io/<tên repo>`.
- Mặc định các tài nguyên của dự án sau khi build nó sẽ đi từ `root` ở trên, nhưng tài nguyên thật sự lại nằm trong `/<tên repo>/`. Vì vậy bạn cần thêm tiền tố `/<tên repo>/` vào trước khi build.
- Sửa `nuxt.config.ts` thêm `baseURL` như sau:

```ts
app: {
    baseURL: '/<yourresponame>/',
    },

```

#### Cách 1 (tự động)

IMPORTANT:

    - TÊN THƯ MỤC DỰ ÁN TRÊN MÁY PHẢI TRÙNG VỚI TÊN REPO ĐỂ TẠO SYMLINK CHO ĐÚNG.
    - Nên xóa Cache của GitActions(TRƯỚC KHI COMMIT) mỗi lần đổi tên repo hay thay đổi `baseURL` để tránh lỗi không tìm thấy trang ở bước Artifact.

- Tại github repo:

1. Vào repo của bạn tại github, chọn `Settings` > `Pages`.
2. Chọn Source `Github Actions` trong mục `Build and deployment`.

- Tại máy local:

3. Kiểm tra file `/.github/workflows/nuxtjs.yml`:

- Chọn nhánh sẽ deploy trong đoạn `branches: ["<nhánh sẽ deploy>"]`
- Kiểm tra lại đoạn `path: ./dist`. File này là symlink đến thư mục sau build.
  - Có thể kiểm tra thử xem nó có hoạt động đúng không bằng cách build thử trên máy local với lệnh `npm run generate`
  - Chạy lệnh `ls -l -a` tại thư mục gốc, xem nó có và trỏ tới thư mục đầu ra của `npm run generate` không? Ví dụ `.output/public`. Đây là thư mục chứa các file tĩnh đã được build.
- Nếu có lỗi xóa hết thư mục `.nuxt`, `.output`, `dist` và chạy lại lệnh `npm run generate` để tạo lại các thư mục này để kiểm tra.

4. Commit và push lên repo của bạn. GitHub Actions sẽ tự động build và deploy theo cấu hình của file `nuxtjs.yml` ở trên lên GitHub Pages.

#### Cách 2 (chỉnh sửa thủ công)

Không dùng symlink `./dist` nữa

1. Sau đó kiểm tra kết quả build `npm run generate` trên máy local như sau:

```
ℹ Prerendered 1080 routes in 36.317 seconds                                                                                                            nitro 10:57:34 PM
✔ Generated public .output/public                                                                                                                      nitro 10:57:34 PM
✔ You can preview this build using npx serve .output/public                                                                                            nitro 10:57:34 PM
✔ You can now deploy .output/public to any static hosting!                                                                                              nuxi 10:57:34 PM
```

Hoặc ở mục Deploy trong GitHub Actions, bước `Static HTML export with Nuxt` sẽ có dòng `✔ Generated public .output/public` nếu build thành công. Kết quả giống như chạy ở local vì dùng chung lệnh `npm run generate` để build.

```
[info] [nitro] Prerendered 1080 routes in 49.285 seconds
[success] [nitro] Generated public .output/public
[success] [nitro] You can preview this build using `npx serve .output/public`
[success] [nuxi] You can now deploy `.output/public` to any static hosting!
```

2. Sửa `/.github/workflows/nuxtjs.yml` đoạn `path` dẫn về đúng thư mục sau khi build phía trên bước 2:

```yaml
- name: Upload artifact
  uses: actions/upload-pages-artifact@v3
  with:
    name: github-pages
    path: ./.output/public/
```

3. Commit và push lên repo của bạn.
