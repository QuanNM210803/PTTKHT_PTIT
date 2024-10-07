<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Forbidden</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> <!-- Đường dẫn đến file CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            display: flex;
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
            height: 100vh; /* Đặt chiều cao của body bằng chiều cao của viewport */
            margin: 0; /* Xóa margin mặc định của body */
        }

        .error-container {
            border: 1px solid #dc3545;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center; /* Căn giữa nội dung bên trong container */
        }

        h2 {
            color: #dc3545;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h2>Không có quyền truy cập</h2> <!-- Sửa từ </h1> thành </h2> để thống nhất -->
        <p>Xin lỗi, bạn không có quyền truy cập vào trang này.</p>
    </div>
</body>
</html>
