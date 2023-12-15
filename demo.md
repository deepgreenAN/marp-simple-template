---
marp: true
# 1280px × 720px
size: 16:9
theme: theme
paginate: true
math: true
footer:
  <div class="footer-container">
    <div class="date">2000年00月00日</div>
    <div class="logo-container">
      <img src="./assets/template/fuga-logo.svg">
    </div>
  </div>
  <div class="bottom-bar">

style: |
  .state div {
    --radius: 10px;
  }

---
<!-- _class: "title-page-v1" -->
<!-- _paginate: "skip" -->

# 公開鍵暗号RSAについて

## hogehogeConf2024

<div class="author-container">
  <div>FugaFuga大学 研究室 XXXX</div>
  <div>2024年1月1日</div>
</div>

---
<!-- _class: "toc-page-v1" -->
<!-- _header: 
  <div class="header-container">
    <h1>目次</h1>
  </div>
 -->

- RSAの前提知識１
- RSAの前提知識２(mod演算で成り立つ法則)
- RSAの利用例
- rsaクレートを使ってみよう
- e
- f
- g
- h
- i
- j
- k

---
<!-- _class: "toc-page-v2" -->
<!-- _header: 
  <div class="header-container">
    <h1>目次</h1>
  </div>
 -->

- RSAの前提知識１
- RSAの前提知識２(mod演算で成り立つ法則)
- RSAの利用例
- d
- e
- f
- g
- h
- i
- j
- k

---
<!-- _class: "layout-col-2 text-large" -->
<!-- _header: 
  <div class="header-container">
    <h1>自己紹介</h1>
    <div class="state">
      <div class="active">自己紹介</div>
      <div>前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div>コード</div>
      <div>付録</div>
    </div>
  </div>
 -->

<div class="left-container">
  
  <div class="my-name">
    Marp Rust 太郎
  </div>

hogehogeに関わる開発

- aaa
  - ccc
  - ddd
- bbb

fugafugaに関わる開発

- ccc
- ddd

</div>
<div class="right-container">
  <div class="img-container">
    <img src="./assets/demo/pc.jpg" alt="pc">
    <div class="caption">
      フリー素材のPC
    </div>
  </div>
</div>

<!-- 以下はスタイル -->

<style scoped>
  .my-name {
    font-size: var(--font-size-2);
    color: var(--primary-color);
  }
  section.layout-col-2 {
    --right-width: 60%;
  }
  .left-container {
    margin-left: 10%;
    margin-top: 10%;
  }
</style>

---

<!-- _header: 
  <div class="header-container">
    <h1>RSAの前提知識</h1>
    <div class="state">
      <div>自己紹介</div>
      <div class="active">前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div>コード</div>
      <div>付録</div>
    </div>
  </div>
 -->

<div class="theorem">
  <div class="caption">
    フェルマーの小定理
  </div>

$p$を素数，$a$を整数とすると

$$
  a^p \equiv a \quad( \mod p) \\
$$

ここで$a$と$p$を互いに素とした場合

$$
  a^{p-1} \equiv 1 \quad(\mod p)
$$

</div>

これを数学的帰納法で証明する．まず，$a = 1$のときは明らかに正しい．
次に$(m+1)^p$について考えると
$$
 (m + 1) ^p = m^p + _pC_1m^{p-1} + _pC_{2}m^{p-1} + \ldots + _{p}C_{p-1}m + 1
$$
ここで
$$
  _pC_k = \frac{p(p-1)\cdots(p - k + 1)}
  {k(k-1)\cdots 1} \\
$$
は$p$が素数であるため$p$で約分できず，$p$の倍数であるから
$$
  (m + 1)^p \equiv m^p + 1 \quad (\mod p)
$$

---

<!-- _header: 
  <div class="header-container">
    <h1>rsaクレートを使ってみよう</h1>
    <div class="state">
      <div>自己紹介</div>
      <div>前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div class="active">コード</div>
      <div>付録</div>
    </div>
  </div>
 -->

## Example

公開鍵を用いて暗号化したデータを秘密鍵を用いて復号してみる．

```rust
use rsa::{Pkcs1v15Encrypt, RsaPrivateKey, RsaPublicKey};

let mut rng = rand::thread_rng();
let bits = 2048;
let priv_key = RsaPrivateKey::new(&mut rng, bits).expect("failed to generate a key");
let pub_key = RsaPublicKey::from(&priv_key);

// Encrypt
let data = b"hello world";
let enc_data = pub_key.encrypt(&mut rng, Pkcs1v15Encrypt, &data[..]).expect("failed to encrypt");
assert_ne!(&data[..], &enc_data[..]);

// Decrypt
let dec_data = priv_key.decrypt(Pkcs1v15Encrypt, &enc_data).expect("failed to decrypt");
assert_eq!(&data[..], &dec_data[..]);
```

もし`RsaPrivateKey::new`による鍵の生成が遅い場合はリリースビルドを行う．

---
<!-- _header: 
  <div class="header-container">
    <h1>なんかの表</h1>
    <div class="state">
      <div>自己紹介</div>
      <div>前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div>コード</div>
      <div class="active">付録</div>
    </div>
  </div>
 -->

| 項目1          | 項目2 | 他と比べて長い項目1 | ほかとくらべてさらにながい項目 |
|----------------|-------|---------------------|--------------------------------|
| 15.6           | 十    | $e = mc^2$          | 22.3                           |
| 12.4           | 一    | $x = x$             | ここに日本語が入る           |
| ここに長い要素 | 五    | $y = ax + b$        | 12.6                           |

---
<!-- _class: "footnote-page" -->

<!-- _header: 
  <div class="header-container">
    <h1>脚注</h1>
    <div class="state">
      <div>自己紹介</div>
      <div>前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div>コード</div>
      <div class="active">付録</div>
    </div>
  </div>
 -->

bbb [1]
cccc
dddd
<div>
  aaa
</div>
<div>
  bbb
</div>

<div class="footnote">
  [1] aa
</div>

---
<!-- _class: "layout-flex" -->
<!-- _header: 
  <div class="header-container">
    <h1>引用の種類</h1>
    <div class="state">
      <div>自己紹介</div>
      <div>前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div>コード</div>
      <div class="active">付録</div>
    </div>
  </div>
 -->

> 引用された文章

<div class="info">
  <div class="caption">INFO</div>
  情報の内容
</div>

<div class="warn">
  <div class="caption">WARN</div>
  警告の内容
</div>

<div class="theorem">
  <div class="caption">HOGE HOGE の定理</div>
  定理の内容
</div>

<style scoped>
  section.layout-flex {
    gap: 20px;
  }
</style>

---

<!-- _class: "layout-flex" -->
<!-- _header: 
  <div class="header-container">
    <h1>状態</h1>
  </div>
 -->

<div class="state">
  <div class="active">aaaaa</div>
  <div>bbbbb</div>
  <div>ccccc</div>
  <div>ddddd</div>
  <div>ddddd</div>
</div>

<div class="state">
  <div>aaaaa</div>
  <div class="active">bbbbb</div>
  <div>ccccc</div>
  <div>ddddd</div>
  <div>ddddd</div>
</div>

<div class="state">
  <div>aaaaa</div>
  <div>bbbbb</div>
  <div class="active">ccccc</div>
  <div>ddddd</div>
  <div>ddddd</div>
</div>

<div class="state">
  <div>aaaaa</div>
  <div>bbbbb</div>
  <div>ccccc</div>
  <div class="active">ddddd</div>
  <div>ddddd</div>
</div>

<div class="state">
  <div>aaaaa</div>
  <div>bbbbb</div>
  <div>ccccc</div>
  <div>ddddd</div>
  <div class="active">ddddd</div>
</div>

<style scoped>
  .state {
    position: static;
  }

  .state div{
    width: 200px;
    --radius: 10px;
    --border-width: 5px;
  }

  section.layout-flex {
    gap: 20px;
  }
</style>

---

<!-- _class: "layout-grid-22"-->

<!-- justify-selfとalign-selfを指定する． -->

<div class="img-container" style="justify-self:end;align-self:end">
  <img src="./assets/demo/pc.jpg" alt="pc">
</div>

<div class="img-container" style="justify-self:start;align-self:end">
  <img src="./assets/demo/pc.jpg" alt="pc">
</div>

<div class="img-container" style="justify-self:end;align-self:start">
  <img src="./assets/demo/pc.jpg" alt="pc">
</div>

<div class="img-container" style="justify-self:start;align-self:start">
  <img src="./assets/demo/pc.jpg" alt="pc">
</div>

<style scoped>
  section {
    /* スライドのパディングを変更 */
    --content-padding-top: 50px;
    --content-padding-right: 0px;
    --content-padding-bottom: 0px;
    --content-padding-left: 0px;
  }
  section.layout-grid-22 {
    /* セルの高さと幅を指定 */
    --cell-width: 1fr;
    --cell-height: 300px;
    gap: 30px;
  }
  .img-container {
    height: 100%;
  }
  .img-container>img {
    height: 100%;
  }
</style>

---

<!-- _header: 
  <div class="header-container">
    <h1>パワポでよく見る図形</h1>
    <div class="state">
      <div>自己紹介</div>
      <div>前提知識</div>
      <div>公開鍵と秘密鍵</div>
      <div>コード</div>
      <div class="active">付録</div>
    </div>
  </div>
 -->

<div class="svg-arrow">

<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <use href="#right-arrow-svg" />
</svg>

</div>

<div class="right-curly-brace">&#x7D;</div>

<div class="fukidashi">
  こちらは吹き出しです
</div>

<style scoped>
  .svg-arrow {
    height: 200px;
    width: fit-content;
    color: green;
    transform: rotate(15deg);
  }
  .svg-arrow svg {
    height: 100%;
  }
  .right-curly-brace {
    font-size: 150px;
    color: blue;
  }
  .fukidashi {
    background-color: #32a8a4;
    --tsuno-rotate: -5deg;
    --tsuno-left: 60%;
  }
</style>

---
<!-- _class: "end-page" -->
<!-- _header: 
  <div class="header-container">
    <h1>最後のページ</h1>
  </div>
 -->

発表は以上となります．ご静聴ありがとうございました．

<!-- 以下はsvgスプライト用 -->

<style scoped>
  /* svgスプライト用コンテナは非表示にする */
  .svg-use {
    display: none;
  }
</style>

<div class="svg-use">

<svg id="right-arrow-svg" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M14.7055 18.9112C14.2784 18.7306 14 18.3052 14 17.8333V15H3C2.44772 15 2 14.5523 2 14V10C2 9.44772 2.44772 9 3 9H14V6.1667C14 5.69483 14.2784 5.26942 14.7055 5.08884C15.1326 4.90826 15.6241 5.00808 15.951 5.34174L21.6653 11.175C22.1116 11.6307 22.1116 12.3693 21.6653 12.825L15.951 18.6583C15.6241 18.9919 15.1326 19.0917 14.7055 18.9112Z" fill="currentColor"/>
</svg>

</div>
