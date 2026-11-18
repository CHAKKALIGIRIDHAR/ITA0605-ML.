"""
Embed app.jsx into index.html so it runs seamlessly under file:/// without Chrome CORS restrictions,
while also remaining fully compatible with http://localhost:8000
"""

import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
INDEX_PATH = os.path.join(BASE_DIR, "index.html")
APP_JSX_PATH = os.path.join(BASE_DIR, "public", "app.jsx")

with open(APP_JSX_PATH, "r", encoding="utf-8") as f:
    app_jsx_content = f.read()

html_template = f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>BayeSphere | Predictive Analytics for Hospital Readmission Risk Assessment</title>
  
  <!-- Google Fonts: Inter & Outfit -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {{
      darkMode: 'class',
      theme: {{
        extend: {{
          colors: {{
            brand: {{
              50: '#f0f7ff',
              100: '#e0effe',
              200: '#bae0fd',
              300: '#7cc7fb',
              400: '#38a9f8',
              500: '#0e8ce9',
              600: '#0270c7',
              700: '#0359a1',
              800: '#074b84',
              900: '#0b3f6e',
              950: '#072849',
            }},
            navy: {{
              800: '#1e293b',
              850: '#172033',
              900: '#0f172a',
              950: '#090d16',
            }},
            medical: {{
              blue: '#2563eb',
              cyan: '#06b6d4',
              teal: '#0d9488',
              slate: '#f8fafc',
            }}
          }},
          fontFamily: {{
            sans: ['Inter', 'sans-serif'],
            display: ['Outfit', 'sans-serif'],
            mono: ['JetBrains Mono', 'monospace'],
          }}
        }}
      }}
    }}
  </script>

  <!-- React 18 & ReactDOM -->
  <script crossorigin src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
  <script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
  
  <!-- Babel Standalone for JSX compilation in browser -->
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

  <style>
    body {{
      font-family: 'Inter', sans-serif;
      background-color: #f8fafc;
      color: #0f172a;
      -webkit-font-smoothing: antialiased;
    }}
    
    /* Custom scrollbar */
    ::-webkit-scrollbar {{
      width: 6px;
      height: 6px;
    }}
    ::-webkit-scrollbar-track {{
      background: #f1f5f9;
    }}
    ::-webkit-scrollbar-thumb {{
      background: #cbd5e1;
      border-radius: 9999px;
    }}
    ::-webkit-scrollbar-thumb:hover {{
      background: #94a3b8;
    }}

    /* Print styles for clinical reports */
    @media print {{
      body {{
        background: white !important;
        color: black !important;
      }}
      .no-print {{
        display: none !important;
      }}
      .print-only {{
        display: block !important;
      }}
      .print-shadow-none {{
        box-shadow: none !important;
        border: 1px solid #e2e8f0 !important;
      }}
      .page-break {{
        page-break-before: always;
      }}
    }}
    
    @keyframes pulse-slow {{
      0%, 100% {{ opacity: 1; transform: scale(1); }}
      50% {{ opacity: 0.85; transform: scale(1.02); }}
    }}
    .animate-pulse-slow {{
      animation: pulse-slow 3s infinite ease-in-out;
    }}
  </style>
</head>
<body class="bg-slate-50 text-slate-900 antialiased selection:bg-blue-100 selection:text-blue-900">
  <div id="root">
    <!-- Initial Loading State -->
    <div class="min-h-screen flex flex-col items-center justify-center bg-slate-900 text-white p-6">
      <div class="relative w-16 h-16 mb-4">
        <div class="absolute inset-0 rounded-full border-4 border-cyan-500/20 animate-ping"></div>
        <div class="w-16 h-16 rounded-2xl bg-gradient-to-tr from-blue-600 to-cyan-500 flex items-center justify-center shadow-lg shadow-cyan-500/30">
          <svg class="w-8 h-8 text-white animate-spin" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
        </div>
      </div>
      <h2 class="text-xl font-bold font-display tracking-tight text-white">BayeSphere ReadmitIQ</h2>
      <p class="text-slate-400 text-sm mt-1">Initializing Bayesian Clinical Probability Engine...</p>
    </div>
  </div>

  <!-- Inline Application Script (Zero CORS restrictions on file://) -->
  <script type="text/babel">
{app_jsx_content}
  </script>
</body>
</html>
"""

with open(INDEX_PATH, "w", encoding="utf-8") as f:
    f.write(html_template)

print(f"Successfully generated standalone index.html ({len(html_template)} bytes)")
