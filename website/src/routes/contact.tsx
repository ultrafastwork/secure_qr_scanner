import { Title } from "@solidjs/meta";
import { Github } from "lucide-solid";

export default function Contact() {
  return (
    <>
      <Title>Contact - Secure QR Scanner</Title>
      <main class="min-h-screen bg-bg-dark text-white pt-16">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-20">
        <div class="max-w-4xl mx-auto">
          {/* Header */}
          <div class="text-center mb-16 animate-fade-in-up">
            <div class="w-16 h-16 mx-auto mb-6 rounded-2xl bg-linear-to-br from-primary to-secondary flex items-center justify-center shadow-glow-violet">
              <Github size={32} class="text-white" />
            </div>
            <h1 class="text-4xl sm:text-5xl font-bold mb-4">
              Get in <span class="bg-linear-to-r from-primary to-secondary bg-clip-text text-transparent">Touch</span>
            </h1>
            <p class="text-lg text-gray-400">
              Connect with us on GitHub
            </p>
          </div>

          {/* GitHub Card */}
          <div class="max-w-2xl mx-auto">
            <div class="p-12 rounded-2xl bg-glass-subtle border border-white/10 backdrop-blur-sm hover:bg-glass-hover transition-all animate-fade-in-up animation-delay-100">
              <div class="text-center">
                <div class="w-16 h-16 mx-auto mb-6 rounded-xl bg-secondary/20 flex items-center justify-center">
                  <Github size={32} class="text-secondary" />
                </div>
                <h3 class="text-2xl font-semibold mb-4">GitHub Repository</h3>
                <p class="text-gray-400 mb-8 text-lg">
                  Report issues, request features, or contribute to the Secure QR Scanner project
                </p>
                <a 
                  href="https://github.com/ultrafastwork/secure_qr_scanner" 
                  target="_blank"
                  rel="noopener noreferrer"
                  class="inline-flex items-center gap-3 px-8 py-4 bg-linear-to-r from-primary to-secondary rounded-lg text-white font-semibold hover:shadow-glow-violet transition-all hover:scale-105"
                >
                  <Github size={20} />
                  Visit GitHub Repository
                  <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                  </svg>
                </a>
              </div>
            </div>
          </div>

          {/* Back to Home */}
          <div class="mt-12 text-center animate-fade-in-up animation-delay-400">
            <a
              href="/"
              class="inline-flex items-center gap-2 px-6 py-3 bg-linear-to-r from-primary to-secondary rounded-lg text-white font-semibold hover:shadow-glow-violet transition-all hover:scale-105"
            >
              <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              Back to Home
            </a>
          </div>
        </div>
      </div>
    </main>
    </>
  );
}
