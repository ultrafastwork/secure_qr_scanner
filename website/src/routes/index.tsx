import { Title } from "@solidjs/meta";
import { Scan, Shield, Zap, Download, Github } from "lucide-solid";

export default function Home() {
  const features = [
    {
      icon: Scan,
      title: "Fast Scanning",
      description: "Quick QR code and barcode detection using reliable scanning technology"
    },
    {
      icon: Shield,
      title: "Secure & Private",
      description: "Your data stays on your device. No tracking, no ads, no data collection"
    },
    {
      icon: Zap,
      title: "Instant Actions",
      description: "Open links, connect to WiFi, add contacts, and more with a single tap"
    }
  ];

  const stats = [
    { icon: Github, label: "Open Source", link: "https://github.com/ultrafastwork/secure_qr_scanner" },
    { value: "⚡", label: "Fast & Efficient" },
    { value: "📱", label: "Android First" }
  ];

  return (
    <>
      <Title>Secure QR Scanner - Fast, Private & Powerful QR Code Reader</Title>
      <main class="min-h-screen bg-bg-dark text-white pt-16">
        {/* Hero Section */}
        <section class="relative overflow-hidden">
          {/* Gradient Background */}
          <div class="absolute inset-0 bg-linear-to-br from-primary/20 via-transparent to-secondary/20" />
          <div class="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,rgba(139,92,246,0.15),transparent_50%)]" />
          <div class="absolute inset-0 bg-[radial-gradient(circle_at_70%_50%,rgba(217,70,239,0.15),transparent_50%)]" />
          
          <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-20 lg:py-32 relative">
            <div class="max-w-4xl mx-auto text-center">
              {/* Badge */}
              <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-glass-subtle border border-white/10 backdrop-blur-sm mb-8 animate-fade-in-up">
                <Zap size={16} class="text-primary" />
                <span class="text-sm text-gray-300">Now in Internal Testing • Android App</span>
              </div>

              {/* Heading */}
              <h1 class="text-5xl sm:text-6xl lg:text-7xl font-bold mb-6 animate-fade-in-up animation-delay-100">
                <span class="bg-linear-to-r from-primary via-purple to-secondary bg-clip-text text-transparent">
                  Scan QR Codes & Barcodes,
                </span>
                <br />
                <span class="text-white">Securely & Fast</span>
              </h1>

              {/* Description */}
              <p class="text-lg sm:text-xl text-gray-300 mb-10 max-w-2xl mx-auto animate-fade-in-up animation-delay-200">
                A modern QR code and barcode scanner with useful features, clean design, and zero compromises on privacy.
              </p>

              {/* CTA Buttons */}
              <div class="flex flex-col sm:flex-row gap-4 justify-center items-center mb-16 animate-fade-in-up animation-delay-300">
                <a
                  href="#download"
                  class="group w-full sm:w-auto px-8 py-4 bg-linear-to-r from-primary to-secondary rounded-xl text-white font-semibold hover:shadow-glow-violet transition-all hover:scale-105 flex items-center justify-center gap-2"
                >
                  <Download size={20} />
                  Download Now
                  <svg class="w-4 h-4 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </a>
                <a
                  href="#features"
                  class="w-full sm:w-auto px-8 py-4 bg-glass-subtle border border-white/10 backdrop-blur-sm rounded-xl text-white font-semibold hover:bg-glass-hover transition-all"
                >
                  Learn More
                </a>
              </div>

              {/* Stats */}
              <div class="grid grid-cols-3 gap-8 max-w-2xl mx-auto animate-fade-in-up animation-delay-400">
                {stats.map((stat) => (
                  <div class="text-center">
                    {stat.link ? (
                      <a 
                        href={stat.link}
                        target="_blank"
                        rel="noopener noreferrer"
                        class="inline-flex flex-col items-center gap-2 group"
                      >
                        <div class="text-4xl sm:text-5xl mb-2 transition-transform group-hover:scale-110 group-hover:text-primary">
                          {stat.icon && <stat.icon size={48} />}
                        </div>
                        <div class="text-sm text-gray-400 font-medium group-hover:text-primary transition-colors">{stat.label}</div>
                      </a>
                    ) : (
                      <>
                        <div class="text-4xl sm:text-5xl mb-2">
                          {stat.value}
                        </div>
                        <div class="text-sm text-gray-400 font-medium">{stat.label}</div>
                      </>
                    )}
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        {/* Features Section */}
        <section id="features" class="py-20 lg:py-32 relative">
          <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            {/* Section Header */}
            <div class="text-center max-w-3xl mx-auto mb-16">
              <h2 class="text-4xl sm:text-5xl font-bold mb-4">
                Why Choose <span class="bg-linear-to-r from-primary to-secondary bg-clip-text text-transparent">Secure QR</span>?
              </h2>
              <p class="text-lg text-gray-400">
                Packed with features that make scanning fast, safe, and convenient
              </p>
            </div>

            {/* Feature Cards */}
            <div class="grid md:grid-cols-3 gap-8">
              {features.map((feature, index) => (
                <div 
                  class="group p-8 rounded-2xl bg-glass-subtle border border-white/10 backdrop-blur-sm hover:bg-glass-hover hover:border-primary/50 transition-all duration-300 hover:scale-105"
                  style={{ "animation-delay": `${index * 100}ms` }}
                >
                  <div class="w-14 h-14 rounded-xl bg-linear-to-br from-primary to-secondary flex items-center justify-center mb-6 group-hover:shadow-glow-violet transition-shadow">
                    <feature.icon size={28} class="text-white" />
                  </div>
                  <h3 class="text-xl font-semibold mb-3">{feature.title}</h3>
                  <p class="text-gray-400">{feature.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Download Section */}
        <section id="download" class="py-20 lg:py-32 relative">
          <div class="absolute inset-0 bg-linear-to-r from-primary/10 to-secondary/10" />
          
          <div class="container mx-auto px-4 sm:px-6 lg:px-8 relative">
            <div class="max-w-4xl mx-auto text-center">
              <h2 class="text-4xl sm:text-5xl font-bold mb-6">
                Ready to <span class="bg-linear-to-r from-primary to-secondary bg-clip-text text-transparent">Get Started</span>?
              </h2>
              <p class="text-lg text-gray-300 mb-10">
                Join the internal testing program on Android and be among the first to experience Secure QR Scanner
              </p>
              
              <div class="flex flex-col items-center gap-6">
                {/* Android Download Button */}
                <a
                  href="https://play.google.com/store/apps/details?id=one.verysecure.secure_qr_scanner"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="group px-10 py-5 bg-linear-to-r from-primary to-secondary rounded-xl hover:shadow-glow-violet transition-all hover:scale-105 flex items-center justify-center gap-4"
                >
                  <svg class="w-10 h-10" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.53,12.9 20.18,13.18L17.89,14.5L15.39,12L17.89,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z" />
                  </svg>
                  <div class="text-left">
                    <div class="text-xs text-white/80 font-medium">AVAILABLE ON</div>
                    <div class="text-xl font-bold text-white">Google Play</div>
                    <div class="text-xs text-white/60">Internal Testing</div>
                  </div>
                  <svg class="w-5 h-5 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </a>

                {/* Other Platforms */}
                <div class="text-center">
                  <p class="text-sm text-gray-400 mb-3">Exploring Support For</p>
                  <div class="flex items-center gap-6">
                    <div class="flex flex-col items-center gap-2 opacity-40">
                      <svg class="w-8 h-8" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M18.71,19.5C17.88,20.74 17,21.95 15.66,21.97C14.32,22 13.89,21.18 12.37,21.18C10.84,21.18 10.37,21.95 9.1,22C7.79,22.05 6.8,20.68 5.96,19.47C4.25,17 2.94,12.45 4.7,9.39C5.57,7.87 7.13,6.91 8.82,6.88C10.1,6.86 11.32,7.75 12.11,7.75C12.89,7.75 14.37,6.68 15.92,6.84C16.57,6.87 18.39,7.1 19.56,8.82C19.47,8.88 17.39,10.1 17.41,12.63C17.44,15.65 20.06,16.66 20.09,16.67C20.06,16.74 19.67,18.11 18.71,19.5M13,3.5C13.73,2.67 14.94,2.04 15.94,2C16.07,3.17 15.6,4.35 14.9,5.19C14.21,6.04 13.07,6.7 11.95,6.61C11.8,5.46 12.36,4.26 13,3.5Z" />
                      </svg>
                      <span class="text-xs text-gray-500">iOS</span>
                    </div>
                    <div class="flex flex-col items-center gap-2 opacity-40">
                      <svg class="w-8 h-8" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M0,12V13.47A12,12,0,0,0,1,16L3.11,14.67A8.53,8.53,0,0,1,2,12.71V12H0M3.11,9.33L1,8A12,12,0,0,1,3.85,4.87L5.73,6.74A8.53,8.53,0,0,0,3.11,9.33M5.73,17.26L3.85,19.13A12,12,0,0,1,1,16L3.11,14.67A8.53,8.53,0,0,0,5.73,17.26M8,0H9.47A12,12,0,0,1,12,1L10.67,3.11A8.53,8.53,0,0,0,8.71,2H8V0M16,0V2H15.29A8.53,8.53,0,0,0,13.33,3.11L12,1A12,12,0,0,1,16,0M24,8V9.29A8.53,8.53,0,0,0,22.89,11.33L21,10A12,12,0,0,1,24,8M24,16V14A12,12,0,0,1,23,12L20.89,13.33A8.53,8.53,0,0,0,22,15.29V16H24M18.27,6.74L20.15,4.87A12,12,0,0,1,23,8L20.89,9.33A8.53,8.53,0,0,0,18.27,6.74M18.27,17.26A8.53,8.53,0,0,0,20.89,14.67L23,16A12,12,0,0,1,20.15,19.13L18.27,17.26M10.67,20.89L12,23A12,12,0,0,1,8,24V22H8.71A8.53,8.53,0,0,0,10.67,20.89M13.33,20.89A8.53,8.53,0,0,0,15.29,22H16V24A12,12,0,0,1,12,23L13.33,20.89Z" />
                      </svg>
                      <span class="text-xs text-gray-500">Linux</span>
                    </div>
                    <div class="flex flex-col items-center gap-2 opacity-40">
                      <svg class="w-8 h-8" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M0,12V13.47A12,12,0,0,0,2.35,18.35L3.76,16.94A10.06,10.06,0,0,1,2.12,13.47V12H0M2.35,5.65A12,12,0,0,0,0,10.53V12H2.12V10.53A10.06,10.06,0,0,1,3.76,7.06L2.35,5.65M5.65,2.35A12,12,0,0,0,2.35,5.65L3.76,7.06A10.06,10.06,0,0,1,7.23,4.24L5.65,2.35M10.53,0A12,12,0,0,0,5.65,2.35L7.23,3.76A10.06,10.06,0,0,1,10.53,2.12V0M24,10.53V12H21.88V10.53A10.06,10.06,0,0,0,20.24,7.06L21.65,5.65A12,12,0,0,1,24,10.53M24,13.47V12H21.88V13.47A10.06,10.06,0,0,1,20.24,16.94L21.65,18.35A12,12,0,0,1,24,13.47M18.35,21.65A12,12,0,0,0,21.65,18.35L20.24,16.94A10.06,10.06,0,0,1,16.77,19.76L18.35,21.65M13.47,24A12,12,0,0,0,18.35,21.65L16.77,20.24A10.06,10.06,0,0,1,13.47,21.88V24M7.06,3.76L5.65,2.35A12,12,0,0,0,2.35,5.65L3.76,7.06A10.06,10.06,0,0,1,7.06,3.76M16.94,3.76A10.06,10.06,0,0,1,20.24,7.06L21.65,5.65A12,12,0,0,0,18.35,2.35L16.94,3.76M7.06,20.24A10.06,10.06,0,0,0,10.53,21.88V24A12,12,0,0,1,5.65,21.65L7.06,20.24M10.53,24V21.88A10.06,10.06,0,0,1,7.06,20.24L5.65,21.65A12,12,0,0,0,10.53,24M13.47,0A12,12,0,0,1,18.35,2.35L16.94,3.76A10.06,10.06,0,0,0,13.47,2.12V0Z" />
                      </svg>
                      <span class="text-xs text-gray-500">Windows</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Footer */}
        <footer class="border-t border-white/10 py-12">
          <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row justify-between items-center gap-6">
              <div class="text-center md:text-left">
                <div class="text-xl font-bold bg-linear-to-r from-primary to-secondary bg-clip-text text-transparent mb-2">
                  Secure QR Scanner
                </div>
                <p class="text-sm text-gray-400">Fast, Private & Powerful QR Code Reader</p>
              </div>
              
              <div class="flex gap-8 text-sm">
                <a href="/privacy-policy" class="text-gray-400 hover:text-primary transition-colors">Privacy Policy</a>
                <a href="/contact" class="text-gray-400 hover:text-primary transition-colors">Contact</a>
              </div>
              
              <div class="text-sm text-gray-400">
                © 2025 Secure QR Scanner. All rights reserved.
              </div>
            </div>
          </div>
        </footer>
      </main>
    </>
  );
}
