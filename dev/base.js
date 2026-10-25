// shared helpers: window.render(t) is defined per scene
const THEME = new URLSearchParams(location.search).get('theme') || 'dark';
document.documentElement.dataset.theme = THEME;
const CPS = 28; // chars per second when typing
function typed(s, start, t, cps = CPS) { const n = Math.max(0, Math.floor((t - start) / 1000 * cps)); return s.slice(0, n); }
function done(s, start, cps = CPS) { return start + s.length / cps * 1000; }
const esc = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;');
const cursor = t => `<span class="cur" style="opacity:${Math.floor(t / 500) % 2 ? 0 : 1}"></span>`;
