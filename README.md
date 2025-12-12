# Flutter CRUD Multi-Table App

A premium Flutter application with Laravel backend featuring a **Deep Ocean Editorial** design theme.

## 🎨 Design Features

- **Typography**: Crimson Pro (headlines) + Libre Franklin (body)
- **Color Palette**: Deep midnight navy with coral & gold accents
- **Effects**: Glassmorphism cards, animated backgrounds, staggered animations
- **Motion**: Floating geometric shapes, scale/glow button effects

## 📁 Project Structure

```
crud-multi-table-flutter/
├── backend/          # Laravel API (SQLite)
│   ├── app/
│   ├── config/
│   ├── database/
│   └── routes/
└── frontend/         # Flutter App
    └── lib/
        ├── core/     # Theme, widgets, services
        ├── models/   # Data models
        └── screens/  # UI screens
```

## 🚀 Getting Started

### Backend Setup (Laravel)

```bash
cd backend

# Install dependencies
composer install

# Generate app key
php artisan key:generate

# Run migrations & seed data
php artisan migrate --seed

# Start server
php artisan serve
```

**Demo User**: `demo@example.com` / `password123`

### Frontend Setup (Flutter)

```bash
cd frontend

# Get dependencies
flutter pub get

# Run on device/emulator
flutter run
```

> **Note**: Update API URL in `lib/core/services/api_service.dart` if needed.

## 📱 Screens

| Screen | Description |
|--------|-------------|
| Login | Animated auth with glassmorphism form |
| Register | User registration with validation |
| Home | Dashboard with welcome card & menu |
| Products | List with shimmer loading & animations |
| Detail | Product info with owner actions |
| Form | Create/Edit with premium inputs |

## 🔐 API Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | /api/register | ❌ | Register user |
| POST | /api/login | ❌ | Login user |
| GET | /api/products | ❌ | List products |
| GET | /api/products/{id} | ❌ | Get product |
| POST | /api/products | ✅ | Create product |
| PUT | /api/products/{id} | ✅ | Update product |
| DELETE | /api/products/{id} | ✅ | Delete product |
| GET | /api/profile | ✅ | User profile |
| POST | /api/logout | ✅ | Logout |
# 9.5
