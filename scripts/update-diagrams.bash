# !/bin/bash
set -e

# Thư mục chứa file .drawio
source_dir="./src/assets/diagrams"
# Thư mục đích (sẽ trở thành public URL sau khi build)
dest_dir="./src/public/diagrams"

# Bước 1: Dùng Docker để export SVG từ .drawio
docker run $1 -v "$(pwd)":/data rlespinasse/drawio-export -f svg --remove-page-suffix -o _export

# Bước 2: Xóa thư mục đích cũ nếu có
rm -rf "$dest_dir"

# Bước 3: Sao chép các file SVG đã export từ _export/ sang dest_dir
# Giữ lại cấu trúc thư mục nếu có
rsync -av --include='*/' --include='_export/*' --exclude='*' "$source_dir/" "$dest_dir/"

# Bước 4: Di chuyển file từ _export/ ra ngoài và xóa _export/
find "$dest_dir" -type f -path "*/_export/*.svg" -exec sh -c '
  for file; do
    newpath=$(echo "$file" | sed "s/_export\///")
    mkdir -p "$(dirname "$newpath")"
    mv "$file" "$newpath"
  done
' sh {} +

# Bước 5 (tùy chọn): Sửa nội dung đường dẫn bên trong file SVG nếu cần
# Ví dụ: Thay /assets/... => /learnretejs/assets/...
find "$dest_dir" -type f -name '*.svg' -exec sed -i 's|/assets/|/learnretejs/assets/|g' {} \;

# Bước 6: Xóa thư mục _export rỗng còn lại
find "$dest_dir" -type d -name "_export" -exec rm -rf {} +
