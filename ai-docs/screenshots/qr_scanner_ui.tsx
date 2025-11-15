import React, { useState } from 'react';
import { QrCode, Scan, Sparkles, History, Settings, X, ChevronRight, Image, Barcode } from 'lucide-react';

const QRScannerUI = () => {
  const [showMenu, setShowMenu] = useState(false);

  return (
    <div className="min-h-screen bg-black relative overflow-hidden">
      {/* Animated Background */}
      <div className="absolute inset-0 bg-gradient-to-br from-violet-600 via-fuchsia-600 to-purple-700 opacity-20" />
      <div className="absolute inset-0 backdrop-blur-3xl" />
      
      {/* Home Screen */}
      <div className="relative h-screen flex flex-col">
        {/* Header */}
        <div className="p-5 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-9 h-9 bg-gradient-to-br from-violet-500 to-fuchsia-500 rounded-xl flex items-center justify-center">
              <QrCode className="w-5 h-5 text-white" />
            </div>
            <h1 className="text-white text-base font-bold">QR Scanner</h1>
          </div>
          <button 
            onClick={() => setShowMenu(true)}
            className="w-9 h-9 bg-white/10 backdrop-blur-xl rounded-full flex items-center justify-center hover:bg-white/20 transition-all"
          >
            <Settings className="w-4 h-4 text-white" />
          </button>
        </div>

        {/* Main Content - Centered */}
        <div className="flex-1 flex flex-col items-center justify-center px-6">
          {/* Hero Icon */}
          <div className="relative mb-6">
            <div className="absolute inset-0 bg-gradient-to-br from-violet-500 to-fuchsia-500 rounded-full blur-3xl opacity-40" />
            <div className="relative w-36 h-36 bg-gradient-to-br from-violet-500 to-fuchsia-500 rounded-3xl flex items-center justify-center shadow-2xl shadow-violet-500/50">
              <Scan className="w-20 h-20 text-white" />
            </div>
          </div>

          <h2 className="text-white text-xl font-bold mb-8">
            Ready to Scan
          </h2>

          {/* Action Buttons - Grouped & Equal Height */}
          <div className="w-full max-w-sm space-y-2">
            <button className="w-full bg-gradient-to-r from-violet-500 to-fuchsia-500 py-4 rounded-2xl text-white font-semibold flex items-center justify-center gap-2 hover:shadow-xl hover:shadow-violet-500/50 transition-all active:scale-[0.98]">
              <QrCode className="w-5 h-5" />
              Scan QR Code
            </button>

            <button className="w-full bg-white/10 backdrop-blur-xl py-4 rounded-2xl text-white font-semibold flex items-center justify-center gap-2 hover:bg-white/15 transition-all active:scale-[0.98]">
              <Barcode className="w-5 h-5" />
              Scan Barcode
            </button>

            <button className="w-full bg-white/10 backdrop-blur-xl py-4 rounded-2xl text-white font-semibold flex items-center justify-center gap-2 hover:bg-white/15 transition-all active:scale-[0.98]">
              <Image className="w-5 h-5" />
              Scan from Gallery
            </button>
          </div>
        </div>

        {/* Bottom Quick Access Buttons */}
        <div className="p-5 pb-6">
          <div className="flex gap-2 justify-center">
            <button className="flex items-center gap-1.5 bg-white/5 backdrop-blur-xl px-4 py-2 rounded-full hover:bg-white/10 transition-all active:scale-95">
              <Sparkles className="w-4 h-4 text-violet-400" />
              <span className="text-white text-xs font-medium">Generate</span>
            </button>
            <button className="flex items-center gap-1.5 bg-white/5 backdrop-blur-xl px-4 py-2 rounded-full hover:bg-white/10 transition-all active:scale-95">
              <History className="w-4 h-4 text-fuchsia-400" />
              <span className="text-white text-xs font-medium">History</span>
            </button>
            <button 
              onClick={() => setShowMenu(true)}
              className="flex items-center gap-1.5 bg-white/5 backdrop-blur-xl px-4 py-2 rounded-full hover:bg-white/10 transition-all active:scale-95"
            >
              <Settings className="w-4 h-4 text-purple-400" />
              <span className="text-white text-xs font-medium">More</span>
            </button>
          </div>
        </div>
      </div>

      {/* Full Screen Menu Overlay */}
      {showMenu && (
        <div className="fixed inset-0 z-50 bg-black/95 backdrop-blur-2xl animate-fade-in">
          <div className="h-full flex flex-col p-5">
            {/* Menu Header */}
            <div className="flex items-center justify-between mb-8">
              <h2 className="text-xl font-bold text-white">Menu</h2>
              <button 
                onClick={() => setShowMenu(false)}
                className="w-10 h-10 bg-white/10 rounded-full flex items-center justify-center hover:bg-white/20 transition-all"
              >
                <X className="w-5 h-5 text-white" />
              </button>
            </div>

            {/* Menu Items */}
            <div className="flex-1 space-y-2">
              <button 
                onClick={() => setShowMenu(false)}
                className="w-full bg-gradient-to-r from-violet-600 to-fuchsia-600 p-5 rounded-2xl flex items-center justify-between group hover:shadow-lg hover:shadow-violet-500/50 transition-all"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/20 rounded-xl flex items-center justify-center">
                    <Scan className="w-5 h-5 text-white" />
                  </div>
                  <div className="text-left">
                    <p className="text-white font-semibold">Scan QR Code</p>
                    <p className="text-white/60 text-xs">Open camera scanner</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-white/60 group-hover:text-white transition-colors" />
              </button>

              <button className="w-full bg-white/5 backdrop-blur-xl p-5 rounded-2xl flex items-center justify-between group hover:bg-white/10 transition-all">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center">
                    <Barcode className="w-5 h-5 text-white" />
                  </div>
                  <div className="text-left">
                    <p className="text-white font-semibold">Scan Barcode</p>
                    <p className="text-white/60 text-xs">EAN, UPC, Code128, etc</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-white/40 group-hover:text-white/60 transition-colors" />
              </button>

              <button className="w-full bg-white/5 backdrop-blur-xl p-5 rounded-2xl flex items-center justify-between group hover:bg-white/10 transition-all">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center">
                    <Sparkles className="w-5 h-5 text-white" />
                  </div>
                  <div className="text-left">
                    <p className="text-white font-semibold">Generate QR</p>
                    <p className="text-white/60 text-xs">Create custom QR codes</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-white/40 group-hover:text-white/60 transition-colors" />
              </button>

              <button className="w-full bg-white/5 backdrop-blur-xl p-5 rounded-2xl flex items-center justify-between group hover:bg-white/10 transition-all">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center">
                    <History className="w-5 h-5 text-white" />
                  </div>
                  <div className="text-left">
                    <p className="text-white font-semibold">History</p>
                    <p className="text-white/60 text-xs">View past scans</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-white/40 group-hover:text-white/60 transition-colors" />
              </button>

              <button className="w-full bg-white/5 backdrop-blur-xl p-5 rounded-2xl flex items-center justify-between group hover:bg-white/10 transition-all">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center">
                    <Settings className="w-5 h-5 text-white" />
                  </div>
                  <div className="text-left">
                    <p className="text-white font-semibold">Settings</p>
                    <p className="text-white/60 text-xs">Preferences & theme</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-white/40 group-hover:text-white/60 transition-colors" />
              </button>
            </div>

            {/* Bottom Info */}
            <div className="pt-5 border-t border-white/10">
              <p className="text-white/40 text-xs text-center">QR Scanner v1.0</p>
            </div>
          </div>
        </div>
      )}

      <style jsx>{`
        @keyframes fade-in {
          from { opacity: 0; }
          to { opacity: 1; }
        }
        .animate-fade-in {
          animation: fade-in 0.2s ease-out;
        }
      `}</style>
    </div>
  );
};

export default QRScannerUI;