# 🌐 Secure QR Scanner - Website

Official website for the Secure QR Scanner mobile app. Built with SolidStart (SolidJS SSR) and TailwindCSS v4.

![SolidJS](https://img.shields.io/badge/SolidJS-2C4F7C?logo=solid)
![TailwindCSS](https://img.shields.io/badge/TailwindCSS-v4-38B2AC?logo=tailwind-css)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript)

---

## 📋 Purpose

This website serves as:
- **Landing Page** - App overview and features showcase
- **Privacy Policy** - Required for Google Play Store publishing
- **Terms of Service** - Legal terms and conditions (not ready)
- **Marketing** - App promotion and user information

---

## ✨ Features

- 🎨 **Purple Gradient Theme** - Matches the Flutter app design
- 🌓 **Dark Mode Support** - Respects `prefers-color-scheme`
- ⚡ **Server-Side Rendering** - Fast initial page loads with SolidStart
- 📱 **Fully Responsive** - Mobile-first design
- ♿ **Accessible** - WCAG 2.1 AA compliant
- 🔍 **SEO Optimized** - Proper meta tags and semantic HTML

---

## 🚀 Quick Start

### Prerequisites
- Node.js 24+ or higher
- pnpm (recommended) or npm

### Installation

```bash
# Install dependencies
pnpm install

# Start development server
pnpm dev

# Build for production
pnpm build

# Start production server
pnpm start
```

### Development

```bash
# Run development server with hot reload
pnpm dev

# Type checking
pnpm typecheck

# Format code (if configured)
pnpm format
```

---

## 📁 Project Structure

```
website/
├── src/
│   ├── routes/              # Page components (file-based routing)
│   │   ├── index.tsx        # Home/landing page
│   │   ├── privacy.tsx      # Privacy policy page
│   │   └── terms.tsx        # Terms of service page
│   ├── components/          # Reusable UI components
│   ├── styles/
│   │   └── app.css          # Global styles & TailwindCSS config
│   └── app.tsx              # Root component
├── public/                  # Static assets
├── app.config.ts            # SolidStart configuration
└── package.json             # Dependencies
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| `SolidStart` | SSR framework |
| `SolidJS` | Reactive UI library |
| `TailwindCSS v4` | Utility-first CSS |
| `TypeScript` | Type safety |
| `@solidjs/meta` | SEO meta tags |
| `@solidjs/router` | File-based routing |

---

## 🔒 Privacy & Security

The website promotes an app that prioritizes user privacy:

- **100% Local Storage** - All scan data and history are stored only on your device using Hive
- **No Data Transmission** - Zero data sent to any server or cloud service
- **No Tracking** - No analytics, no data collection, no third-party tracking
- **Open Source** - Full transparency, audit the code yourself
- **Offline First** - App works without internet connection

This website serves informational purposes only and collects no user data.

---

## 🎨 Design System

### Colors (Purple Gradient Theme)
- **Primary**: `#8B5CF6` (violet-500)
- **Secondary**: `#D946EF` (fuchsia-500)
- **Accent**: `#7C3AED` (violet-600)
- **Additional**: `#A78BFA`, `#E879F9`, `#C084FC`

### Typography
- **Font**: Inter (system-ui fallback)
- Consistent with the Flutter mobile app

### Theme Support
- Light and dark modes
- Respects user's system preference
- CSS custom properties for easy theming

---

## 📄 Pages

### 1. Home/Landing Page (`/`)
- App overview and features
- Download links (when available)
- Screenshots and demo
- Call-to-action sections

### 2. Privacy Policy (`/privacy-policy`)
- Data collection practices
- User privacy rights
- Required for Google Play Store

### 3. Terms of Service (`/terms`) (not ready)
- Usage terms and conditions
- User responsibilities
- Legal disclaimers

---

## 🔍 SEO & Performance

- ✅ Server-side rendering for fast TTFB
- ✅ Proper meta tags (title, description, OG tags)
- ✅ Semantic HTML structure
- ✅ Optimized images and assets
- ✅ Mobile-first responsive design
- ✅ Accessibility compliance

---

## ♿ Accessibility

- Semantic HTML elements
- Proper heading hierarchy (h1 → h2 → h3)
- ARIA labels where needed
- Keyboard navigation support
- Color contrast compliance (WCAG 2.1 AA)
- Screen reader friendly

---

## 🚢 Deployment

This SolidStart app can be deployed to various platforms:

### Node.js (Default)
```bash
pnpm build
pnpm start
```

### Static Export
```bash
# Configure for static export in app.config.ts
pnpm build
```

---

## 🤝 Contributing

This website is part of the Secure QR Scanner project:
- Maintain design consistency with the mobile app
- Ensure responsive design on all screen sizes
- Test accessibility with screen readers

---

## 📝 Development Guidelines

1. **Routing**: Use file-based routing in `src/routes/`
2. **Components**: Create reusable components in `src/components/`
3. **Styling**: Use TailwindCSS utility classes
4. **SEO**: Add proper `<Title>` and `<Meta>` tags to all pages
5. **Accessibility**: Use semantic HTML and ARIA labels
6. **Performance**: Optimize images and minimize bundle size

---

## 🔗 Related Projects

- **Mobile App**: [Secure QR Scanner Flutter App](../)
- **Documentation**: See `../ai-docs/` for design specs

---

## 📄 License

This project is licensed under the MIT License.

---

## 🔗 Resources

- [SolidJS Documentation](https://www.solidjs.com/docs/latest)
- [SolidStart Documentation](https://start.solidjs.com/)
- [TailwindCSS v4 Documentation](https://tailwindcss.com/docs)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)

---

**Status**: In Development  
**Framework**: SolidStart + TailwindCSS v4  
**Last Updated**: Nov 17, 2025
