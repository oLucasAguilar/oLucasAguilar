// node render.cjs <playwright-core> <page.html> <outdir> <fps> <ms> <w> <h>
const { chromium } = require(process.argv[2]);
(async () => {
  const [page, out, fps, ms, w, h] = process.argv.slice(3);
  const b = await chromium.launch({ headless: true, channel: 'chrome' });
  const p = await b.newPage({ viewport: { width: +w, height: +h }, deviceScaleFactor: 1 });
  await p.goto(page);
  await p.evaluate(() => document.fonts.ready);
  const total = +ms || await p.evaluate(() => window.END); const n = Math.ceil(total / 1000 * +fps);
  for (let i = 0; i < n; i++) {
    await p.evaluate(t => window.render(t), i * 1000 / +fps);
    await p.screenshot({ path: `${out}/${String(i).padStart(4, '0')}.png` });
  }
  await b.close();
})();
