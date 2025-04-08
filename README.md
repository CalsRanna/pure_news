# Pure News

一个简洁优雅的新闻阅读应用，基于Flutter开发。

## 功能特点

- RSS订阅管理：支持Google Reader API兼容的RSS服务，提供订阅源管理
- 文章阅读：支持文章列表展示和Web页面阅读
- 用户认证：提供用户登录和认证功能
- 简洁界面：采用Material Design设计风格，提供流畅的阅读体验

## 开发环境配置

1. 安装Flutter SDK
2. 配置开发环境变量
3. 克隆项目代码
4. 运行以下命令安装依赖：

```bash
flutter pub get
```

## 运行项目

```bash
flutter run
```

## 项目结构

```
lib/
├── database/        # 数据库模型
├── dependency_injection/  # 依赖注入
├── page/           # 页面UI
├── route/          # 路由管理
├── service/        # 业务服务
├── util/           # 工具类
└── view_model/     # 视图模型
```

## 贡献

欢迎提交Issue和Pull Request。

## 许可证

本项目基于MIT许可证开源，详见[LICENSE](LICENSE)文件。
