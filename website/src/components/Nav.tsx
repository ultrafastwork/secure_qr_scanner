import { A, useLocation } from "@solidjs/router";
import { createSignal } from "solid-js";
import { Menu, X } from "lucide-solid";

export default function Nav() {
  const location = useLocation();
  const [isOpen, setIsOpen] = createSignal(false);
  
  const active = (path: string) =>
    location.pathname === path
      ? "text-primary font-semibold"
      : "text-gray-300 hover:text-primary transition-colors";

  const navLinks = [
    { href: "/", label: "Home" },
    { href: "/privacy-policy", label: "Privacy Policy" },
    { href: "/contact", label: "Contact" },
  ];

  return (
    <header class="fixed top-0 left-0 right-0 z-50 bg-bg-dark/80 backdrop-blur-lg border-b border-white/10">
      <nav class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          {/* Logo */}
          <A href="/" class="flex items-center space-x-2 group">
            <div class="w-10 h-10 rounded-lg bg-linear-to-br from-primary to-secondary flex items-center justify-center shadow-glow-violet transition-transform group-hover:scale-110">
              <svg class="w-6 h-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v1m6 11h2m-6 0h-2v4m0-11v3m0 0h.01M12 12h4.01M16 20h4M4 12h4m12 0h.01M5 8h2a1 1 0 001-1V5a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1zm12 0h2a1 1 0 001-1V5a1 1 0 00-1-1h-2a1 1 0 00-1 1v2a1 1 0 001 1zM5 20h2a1 1 0 001-1v-2a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1z" />
              </svg>
            </div>
            <span class="text-xl font-bold bg-linear-to-r from-primary to-secondary bg-clip-text text-transparent">
              Secure QR
            </span>
          </A>

          {/* Desktop Navigation */}
          <ul class="hidden md:flex items-center space-x-8">
            {navLinks.map((link) => (
              <li>
                <A href={link.href} class={`text-sm font-medium transition-all ${active(link.href)}`}>
                  {link.label}
                </A>
              </li>
            ))}
          </ul>

          {/* CTA Button - Desktop */}
          <div class="hidden md:block">
            <a
              href="#download"
              class="px-6 py-2.5 bg-linear-to-r from-primary to-secondary rounded-lg text-white font-semibold hover:shadow-glow-violet transition-all hover:scale-105"
            >
              Download App
            </a>
          </div>

          {/* Mobile Menu Button */}
          <button
            onClick={() => setIsOpen(!isOpen())}
            class="md:hidden p-2 rounded-lg text-gray-300 hover:text-primary hover:bg-white/5 transition-colors"
            aria-label="Toggle menu"
          >
            {isOpen() ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>

        {/* Mobile Navigation */}
        {isOpen() && (
          <div class="md:hidden py-4 animate-fade-in">
            <ul class="flex flex-col space-y-4">
              {navLinks.map((link) => (
                <li>
                  <A
                    href={link.href}
                    class={`block py-2 text-sm font-medium transition-colors ${active(link.href)}`}
                    onClick={() => setIsOpen(false)}
                  >
                    {link.label}
                  </A>
                </li>
              ))}
              <li class="pt-2">
                <a
                  href="#download"
                  class="block w-full px-6 py-3 bg-linear-to-r from-primary to-secondary rounded-lg text-white font-semibold text-center hover:shadow-glow-violet transition-all"
                  onClick={() => setIsOpen(false)}
                >
                  Download App
                </a>
              </li>
            </ul>
          </div>
        )}
      </nav>
    </header>
  );
}
