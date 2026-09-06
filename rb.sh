#!/bin/bash
cd /data/BLOG || exit 1

# 清理旧文件（保留 files 文件夹和 rb.sh 自己）
find . -maxdepth 1 -type f ! -name "rb.sh" -delete
find . -maxdepth 1 -type d ! -name "files" ! -name "." -exec rm -rf {} \;

mkdir -p blogs

# ===== style.css =====
cat > style.css << 'CSS'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
    background-color: #0d0d0d;
    color: #e0e0e0;
    height: 100vh;
    overflow: hidden;
}

.container {
    display: flex;
    height: 100vh;
    width: 100%;
}

.sidebar {
    width: 240px;
    min-width: 240px;
    background-color: #1a1a1a;
    padding: 30px 20px 20px 20px;
    display: flex;
    flex-direction: column;
    border-right: 1px solid #2a2a2a;
    overflow-y: auto;
}

.sidebar-header {
    text-align: center;
    padding-bottom: 20px;
    border-bottom: 1px solid #2a2a2a;
    margin-bottom: 20px;
}

.sidebar-avatar {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #2a2a2a;
    background-color: #1a1a1a;
    display: block;
    margin: 0 auto 12px auto;
}

.sidebar-name {
    font-size: 18px;
    font-weight: 600;
    color: #ffffff;
    margin: 0 0 4px 0;
}

.sidebar-sig {
    font-size: 13px;
    color: #888888;
    margin: 0;
}

.nav-menu {
    list-style: none;
    flex: 1;
    padding: 0;
    margin: 0;
}

.nav-menu li {
    margin-bottom: 4px;
}

.nav-menu a {
    display: block;
    padding: 8px 12px;
    color: #b0b0b0;
    text-decoration: none;
    border-radius: 4px;
    font-size: 15px;
}

.nav-menu a:hover {
    background-color: #2a2a2a;
    color: #ffffff;
}

.nav-menu a.active {
    background-color: #2a2a2a;
    color: #ffffff;
}

.contact-info {
    border-top: 1px solid #2a2a2a;
    padding-top: 16px;
    margin-top: auto;
    font-size: 13px;
    color: #888888;
    line-height: 1.8;
}

.contact-info a {
    color: #6ab0ff;
    text-decoration: none;
}

.contact-info a:hover {
    text-decoration: underline;
}

.contact-item {
    display: block;
}

.content {
    flex: 1;
    padding: 40px 50px;
    overflow-y: auto;
    background-color: #0d0d0d;
}

.markdown-body {
    max-width: 800px;
    margin: 0 auto;
    line-height: 1.8;
    color: #e0e0e0;
}

.markdown-body h1 {
    font-size: 28px;
    color: #ffffff;
    border-bottom: 1px solid #2a2a2a;
    padding-bottom: 12px;
    margin-bottom: 20px;
}

.markdown-body h2 {
    font-size: 22px;
    color: #ffffff;
    margin-top: 30px;
    margin-bottom: 16px;
}

.markdown-body h3 {
    font-size: 18px;
    color: #ffffff;
    margin-top: 24px;
    margin-bottom: 12px;
}

.markdown-body p {
    margin-bottom: 16px;
}

.markdown-body ul,
.markdown-body ol {
    margin-bottom: 16px;
    padding-left: 24px;
}

.markdown-body li {
    margin-bottom: 4px;
}

.markdown-body a {
    color: #6ab0ff;
    text-decoration: none;
}

.markdown-body a:hover {
    text-decoration: underline;
}

.markdown-body pre {
    background-color: #1a1a1a;
    padding: 16px;
    border-radius: 6px;
    overflow-x: auto;
    margin-bottom: 16px;
}

.markdown-body pre code {
    background-color: transparent;
    padding: 0;
    font-size: 14px;
}

.markdown-body code {
    background-color: #1a1a1a;
    padding: 2px 6px;
    border-radius: 4px;
    font-size: 14px;
}

.markdown-body blockquote {
    border-left: 3px solid #2a2a2a;
    padding-left: 16px;
    color: #888888;
    margin-bottom: 16px;
}

.markdown-body hr {
    border: none;
    border-top: 1px solid #2a2a2a;
    margin: 30px 0;
}

.post-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.post-list li {
    padding: 10px 0;
    border-bottom: 1px solid #1a1a1a;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.post-list li:last-child {
    border-bottom: none;
}

.post-list a {
    color: #e0e0e0;
    text-decoration: none;
    font-size: 18px;
    padding: 4px 0;
}

.post-list a:hover {
    color: #6ab0ff;
}

.post-date {
    color: #666666;
    font-size: 14px;
    white-space: nowrap;
    margin-left: 20px;
}

::-webkit-scrollbar {
    width: 6px;
}

::-webkit-scrollbar-track {
    background: #0d0d0d;
}

::-webkit-scrollbar-thumb {
    background: #2a2a2a;
    border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
    background: #3a3a3a;
}
CSS

# ===== index.html =====
cat > index.html << 'HTML'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文章 - ChysnTech</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">

        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="files/profile.jpeg" alt="ChysnTech" class="sidebar-avatar">
                <h2 class="sidebar-name">ChysnTech</h2>
                <p class="sidebar-sig">我爱折腾，折腾爱我，从我做起。</p>
            </div>

            <ul class="nav-menu">
                <li><a href="index.html" class="active">文章</a></li>
                <li><a href="links.html">友情链接</a></li>
                <li><a href="about.html">关于我</a></li>
            </ul>

            <div class="contact-info">
                <span class="contact-item">GitHub: <a href="https://github.com/ChysnTech" target="_blank">github.com/ChysnTech</a></span>
                <span class="contact-item">E-Mail: chysntech@outlook.com</span>
                <span class="contact-item">QQ: 3140696291</span>
            </div>
        </nav>

        <main class="content">
            <div class="markdown-body">
                <h1>文章</h1>
                <ul class="post-list">
                    <li>
                        <a href="blogs/post-1.html">第一篇示例文章</a>
                        <span class="post-date">2026-09-06</span>
                    </li>
                </ul>
            </div>
        </main>

    </div>
</body>
</html>
HTML

# ===== links.html =====
cat > links.html << 'HTML'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>友情链接 - ChysnTech</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">

        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="files/profile.jpeg" alt="ChysnTech" class="sidebar-avatar">
                <h2 class="sidebar-name">ChysnTech</h2>
                <p class="sidebar-sig">我爱折腾，折腾爱我，从我做起。</p>
            </div>

            <ul class="nav-menu">
                <li><a href="index.html">文章</a></li>
                <li><a href="links.html" class="active">友情链接</a></li>
                <li><a href="about.html">关于我</a></li>
            </ul>

            <div class="contact-info">
                <span class="contact-item">GitHub: <a href="https://github.com/ChysnTech" target="_blank">github.com/ChysnTech</a></span>
                <span class="contact-item">E-Mail: chysntech@outlook.com</span>
                <span class="contact-item">QQ: 3140696291</span>
            </div>
        </nav>

        <main class="content">
            <div class="markdown-body">
                <h1>友情链接</h1>
                <p>暂无链接，欢迎推荐。</p>
            </div>
        </main>

    </div>
</body>
</html>
HTML

# ===== about.html =====
cat > about.html << 'HTML'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>关于我 - ChysnTech</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">

        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="files/profile.jpeg" alt="ChysnTech" class="sidebar-avatar">
                <h2 class="sidebar-name">ChysnTech</h2>
                <p class="sidebar-sig">我爱折腾，折腾爱我，从我做起。</p>
            </div>

            <ul class="nav-menu">
                <li><a href="index.html">文章</a></li>
                <li><a href="links.html">友情链接</a></li>
                <li><a href="about.html" class="active">关于我</a></li>
            </ul>

            <div class="contact-info">
                <span class="contact-item">GitHub: <a href="https://github.com/ChysnTech" target="_blank">github.com/ChysnTech</a></span>
                <span class="contact-item">E-Mail: chysntech@outlook.com</span>
                <span class="contact-item">QQ: 3140696291</span>
            </div>
        </nav>

        <main class="content">
            <div class="markdown-body">
                <h1>关于我</h1>
                <p>这里填写你的个人简介。</p>

                <h2>技术栈</h2>
                <ul>
                    <li>编程语言: Python / C / C++</li>
                    <li>Web: HTML / CSS / JavaScript</li>
                    <li>操作系统: Linux / Windows</li>
                </ul>

                <h2>联系方式</h2>
                <ul>
                    <li>GitHub: <a href="https://github.com/ChysnTech" target="_blank">github.com/ChysnTech</a></li>
                    <li>E-Mail: chysntech@outlook.com</li>
                    <li>QQ: 3140696291</li>
                </ul>
            </div>
        </main>

    </div>
</body>
</html>
HTML

# ===== blogs/post-1.html =====
cat > blogs/post-1.html << 'HTML'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>第一篇示例文章 - ChysnTech</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">

        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="../files/profile.jpeg" alt="ChysnTech" class="sidebar-avatar">
                <h2 class="sidebar-name">ChysnTech</h2>
                <p class="sidebar-sig">我爱折腾，折腾爱我，从我做起。</p>
            </div>

            <ul class="nav-menu">
                <li><a href="../index.html" class="active">文章</a></li>
                <li><a href="../links.html">友情链接</a></li>
                <li><a href="../about.html">关于我</a></li>
            </ul>

            <div class="contact-info">
                <span class="contact-item">GitHub: <a href="https://github.com/ChysnTech" target="_blank">github.com/ChysnTech</a></span>
                <span class="contact-item">E-Mail: chysntech@outlook.com</span>
                <span class="contact-item">QQ: 3140696291</span>
            </div>
        </nav>

        <main class="content">
            <div class="markdown-body">
                <h1>第一篇示例文章</h1>
                <p><strong>发布日期:</strong> 2026-09-06</p>
                <hr>

                <p>这是你的第一篇博客文章，直接写的 HTML。</p>

                <h2>代码示例</h2>
                <pre><code>print("Hello, ChysnTech!")</code></pre>

                <h2>列表示例</h2>
                <ul>
                    <li>项目一</li>
                    <li>项目二</li>
                    <li>项目三</li>
                </ul>

                <h2>引用</h2>
                <blockquote>我爱折腾，折腾爱我，从我做起。</blockquote>
            </div>
        </main>

    </div>
</body>
</html>
HTML

echo ""
echo "重建完成！"
tree /data/BLOG/
