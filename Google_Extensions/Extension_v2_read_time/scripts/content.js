// 下面是修改版本 能找标题的下面出现阅读时间的提示

// const article = document.querySelector('article');
const article = document.querySelector('body');

if (article) {
  const text = article.textContent;
  const wordMatchRegExp = /[^\s]+/g;
  const words = text.matchAll(wordMatchRegExp);
  const wordCount = [...words].length;
  const readingTime = Math.round(wordCount / 200);
  const badge = document.createElement('p');
  badge.classList.add('color-secondary-text', 'type--caption');
  badge.textContent = `⏱️ 龙哥阅读时间${readingTime} 分钟`;

  // const heading = article.querySelector('body > div.container.main > div > div:nth-child(1) > div.yang-21');
  const heading = article.querySelector('body > div.container.main > div > div:nth-child(1) > div.yang-21');
  // const date = article.querySelector('time')?.parentNode;
  const date = article.querySelector('body > div.container.main > div > div.col-12.post-list > div.yang-12 > div.yang-13')?.parentNode;
  (date ?? heading).insertAdjacentElement('afterend', badge);
}
