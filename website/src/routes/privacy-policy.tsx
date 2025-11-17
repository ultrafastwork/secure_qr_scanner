import { Title } from "@solidjs/meta";
import { FileText, Shield, Database, Share2, AlertTriangle, Scale } from "lucide-solid";

export default function PrivacyPolicy() {
  const lastUpdated = "November 17, 2025";

  const sections = [
    {
      icon: Database,
      title: "Data Storage & Privacy",
      content: [
        {
          heading: "Your Data Stays on Your Device",
          text: "Secure QR Scanner is designed with privacy as a core principle. All scanned data, generated QR codes, and scan history are stored locally on your device. We do not collect, transmit, or store any of your personal information or scan data on our servers."
        },
        {
          heading: "No Data Collection",
          text: "We do not collect, use, or share any personal information. The app operates entirely offline after installation, and no analytics, tracking, or telemetry data is gathered from your usage."
        },
        {
          heading: "Local Storage Only",
          text: "All scan history, favorites, and generated QR codes are stored exclusively in your device's local storage. You have full control over this data and can clear it at any time through the app's settings."
        }
      ]
    },
    {
      icon: Shield,
      title: "Permissions & Security",
      content: [
        {
          heading: "Camera Permission",
          text: "The app requires camera access solely for scanning QR codes and barcodes. Camera data is processed in real-time on your device and is never saved, recorded, or transmitted."
        },
        {
          heading: "Storage Permission",
          text: "Storage permission is requested only to save generated QR codes as images to your device when you choose to do so. This is an optional feature, and you maintain full control over what gets saved."
        },
        {
          heading: "No Background Activity",
          text: "The app does not run any processes in the background and does not access your camera, storage, or any other device features when not actively in use."
        }
      ]
    },
    {
      icon: Share2,
      title: "Content & Sharing",
      content: [
        {
          heading: "User-Generated QR Codes",
          text: "Users can generate and share QR codes containing text, URLs, WiFi credentials, contact information, and other data. When you share a QR code, you are solely responsible for the content encoded within it."
        },
        {
          heading: "Content Responsibility",
          text: "This app is a tool for scanning and generating QR codes and barcodes. It does not contain, promote, or facilitate access to pornographic material, harmful content, health-related advice, or any inappropriate material. Users are responsible for how they use the app and the content they create or share."
        },
        {
          heading: "Free & Open Source",
          text: "Secure QR Scanner is completely free and open source with no advertisements, in-app purchases, or hidden fees. The source code is publicly available, ensuring transparency and allowing the community to verify our privacy commitments. We do not monetize user data or display any third-party content."
        }
      ]
    },
    {
      icon: AlertTriangle,
      title: "Disclaimer & Limitations",
      content: [
        {
          heading: "Use at Your Own Risk",
          text: "Secure QR Scanner is provided \"as is\" without warranties of any kind, either express or implied. While we strive to provide accurate and reliable scanning functionality, we do not guarantee error-free operation or uninterrupted service."
        },
        {
          heading: "Third-Party Content",
          text: "QR codes and barcodes may contain links to external websites or reference third-party content. We are not responsible for the content, privacy practices, or security of any external sites or services accessed through scanned codes."
        },
        {
          heading: "No Liability for User Actions",
          text: "Users are solely responsible for their use of the app and any consequences arising from scanning QR codes, accessing linked content, or sharing generated codes. We assume no liability for any damages, losses, or legal issues resulting from your use of this application."
        }
      ]
    },
    {
      icon: Scale,
      title: "Terms of Use & Legal",
      content: [
        {
          heading: "Acceptance of Terms",
          text: "By installing or using Secure QR Scanner, you automatically and unconditionally agree to all terms outlined in this privacy policy. If you do not agree with these terms, you must immediately uninstall the app and discontinue use."
        },
        {
          heading: "No Legal Claims",
          text: "By using this app, you agree that you will not hold the developer liable for any claims, damages, losses, or legal action of any kind arising from your use of the application. You waive any right to pursue legal action against the developer for any reason related to the app."
        },
        {
          heading: "Prohibited Actions",
          text: "Users agree not to use this app in any manner that could damage, disable, overburden, or impair the app's functionality. You also agree not to cause any harm, financial loss, or reputational damage to the developer through misuse of the application or false claims."
        },
        {
          heading: "Indemnification",
          text: "You agree to indemnify and hold harmless the developer from any claims, damages, losses, liabilities, and expenses (including legal fees) arising from your use of the app, violation of these terms, or infringement of any third-party rights."
        }
      ]
    }
  ];

  return (
    <>
      <Title>Privacy Policy - Secure QR Scanner</Title>
      <main class="min-h-screen bg-bg-dark text-white pt-16">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-20">
        <div class="max-w-5xl mx-auto">
          {/* Header */}
          <div class="text-center mb-12 lg:mb-16 animate-fade-in-up">
            <div class="w-16 h-16 lg:w-20 lg:h-20 mx-auto mb-6 rounded-2xl bg-linear-to-br from-primary to-secondary flex items-center justify-center shadow-glow-violet">
              <FileText size={40} class="text-white" />
            </div>
            <h1 class="text-4xl sm:text-5xl lg:text-6xl font-bold mb-4">
              Privacy <span class="bg-linear-to-r from-primary to-secondary bg-clip-text text-transparent">Policy</span>
            </h1>
            <p class="text-base sm:text-lg text-gray-400 max-w-2xl mx-auto mb-4">
              Your privacy is our top priority. Learn how Secure QR Scanner handles your data and respects your privacy.
            </p>
            <p class="text-sm text-gray-500">
              Last Updated: <span class="text-primary font-medium">{lastUpdated}</span>
            </p>
          </div>

          {/* Summary Card */}
          <div class="mb-12 lg:mb-16 p-6 lg:p-8 rounded-2xl bg-glass-subtle border border-primary/30 backdrop-blur-sm animate-fade-in-up animation-delay-100">
            <div class="flex items-start gap-4">
              <div class="p-3 rounded-xl bg-primary/20 shrink-0">
                <Shield size={28} class="text-primary" />
              </div>
              <div>
                <h2 class="text-2xl lg:text-3xl font-bold mb-3 text-white">Privacy in a Nutshell</h2>
                <ul class="space-y-2 text-gray-300">
                  <li class="flex items-start gap-2">
                    <span class="text-primary mt-1">✓</span>
                    <span><strong class="text-white">No data collection</strong> – We do not submit your data to our server. Your data stays on your device</span>
                  </li>
                  <li class="flex items-start gap-2">
                    <span class="text-primary mt-1">✓</span>
                    <span><strong class="text-white">No ads or tracking</strong> – Completely free and open source</span>
                  </li>
                  <li class="flex items-start gap-2">
                    <span class="text-primary mt-1">✓</span>
                    <span><strong class="text-white">Local storage only</strong> – Data is stored on your device</span>
                  </li>
                  <li class="flex items-start gap-2">
                    <span class="text-primary mt-1">✓</span>
                    <span><strong class="text-white">You're in control</strong> – Clear your data anytime through app settings</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          {/* Detailed Sections */}
          <div class="space-y-8 lg:space-y-12">
            {sections.map((section, sectionIndex) => (
              <div 
                class="animate-fade-in-up"
                style={{ "animation-delay": `${(sectionIndex + 2) * 100}ms` }}
              >
                <div class="p-6 lg:p-8 rounded-2xl bg-glass-subtle border border-white/10 backdrop-blur-sm hover:border-primary/30 transition-all duration-300">
                  {/* Section Header */}
                  <div class="flex items-center gap-4 mb-6">
                    <div class="p-3 rounded-xl bg-linear-to-br from-primary/20 to-secondary/20">
                      <section.icon size={28} class="text-primary" />
                    </div>
                    <h2 class="text-2xl lg:text-3xl font-bold text-white">{section.title}</h2>
                  </div>

                  {/* Section Content */}
                  <div class="space-y-6">
                    {section.content.map((item) => (
                      <div class="pl-0 lg:pl-4">
                        <h3 class="text-xl lg:text-2xl font-semibold text-white mb-2 flex items-center gap-2">
                          <span class="w-2 h-2 rounded-full bg-primary shrink-0"></span>
                          {item.heading}
                        </h3>
                        <p class="text-gray-300 leading-relaxed pl-4 text-sm lg:text-base">
                          {item.text}
                        </p>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            ))}
          </div>

          {/* Important Notice */}
          <div class="mt-12 lg:mt-16 p-6 lg:p-8 rounded-2xl bg-linear-to-br from-primary/10 to-secondary/10 border border-primary/30 backdrop-blur-sm animate-fade-in-up">
            <h3 class="text-xl lg:text-2xl font-bold mb-4 text-white flex items-center gap-3">
              <AlertTriangle size={28} class="text-primary" />
              Important Notice
            </h3>
            <p class="text-gray-300 leading-relaxed mb-4 text-sm lg:text-base">
              By installing, downloading, or using Secure QR Scanner, you acknowledge that you have read, understood, and agree to be bound by this Privacy Policy and all terms contained herein. This agreement is effective immediately upon installation or first use of the application.
            </p>
            <p class="text-gray-300 leading-relaxed text-sm lg:text-base">
              If you do not agree with any part of this policy, you must not install or use this application. Continued use of the app constitutes your acceptance of any updates or changes to this policy.
            </p>
          </div>

          {/* Contact & Updates */}
          <div class="mt-12 lg:mt-16 p-6 lg:p-8 rounded-2xl bg-glass-subtle border border-white/10 backdrop-blur-sm animate-fade-in-up">
            <h3 class="text-xl lg:text-2xl font-bold mb-4 text-white">Updates to This Policy</h3>
            <p class="text-gray-300 leading-relaxed mb-6 text-sm lg:text-base">
              We may update this Privacy Policy from time to time to reflect changes in the app's functionality or legal requirements. 
              Any changes will be posted on this page with an updated "Last Updated" date. You are responsible for reviewing this policy 
              periodically to stay informed about how we protect your privacy.
            </p>
            <div class="pt-6 border-t border-white/10">
              <h4 class="text-lg lg:text-xl font-semibold mb-3 text-white">Questions or Concerns?</h4>
              <p class="text-gray-300 mb-4 text-sm lg:text-base">
                If you have any questions about this Privacy Policy or the app's data practices, please contact us:
              </p>
              <a
                href="/contact"
                class="inline-flex items-center gap-2 px-6 py-3 bg-linear-to-r from-primary to-secondary rounded-lg text-white font-semibold hover:shadow-glow-violet transition-all hover:scale-105 text-sm lg:text-base"
              >
                <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
                Contact Us
              </a>
            </div>
          </div>

          {/* Back to Home */}
          <div class="mt-12 text-center animate-fade-in-up">
            <a
              href="/"
              class="inline-flex items-center gap-2 px-6 py-3 bg-glass-subtle border border-white/10 backdrop-blur-sm rounded-lg text-white font-semibold hover:bg-glass-hover transition-all hover:scale-105"
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
