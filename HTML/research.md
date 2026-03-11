# HTML Research Questions

## 1. GET vs POST

### Critical Security and Functional Differences

| Aspect | `method="GET"` | `method="POST"` |
|--------|----------------|-----------------|
| **Data Location** | Appended to the URL as query parameters (e.g., `?name=John&pass=1234`) | Sent inside the **HTTP request body**, invisible in the URL |
| **Security** | **Insecure** — data is fully visible in the browser address bar, server logs, browser history, and referrer headers | **More secure** — data is not exposed in the URL or browser history |
| **Data Size Limit** | Limited by URL length (~2048 characters) | **No practical limit** — suitable for large payloads (files, long text) |
| **Caching & Bookmarking** | Responses can be cached and URLs can be bookmarked | Responses are **not cached** and cannot be bookmarked |
| **Idempotency** | **Idempotent** — repeated requests produce the same result (safe for reads) | **Not idempotent** — repeated submissions can create duplicate data |
| **Use Case** | Fetching/searching data (e.g., search forms) | Submitting sensitive or mutating data (login, registration, payments) |

### Which to Use for `register.html` — and Why?

**`method="POST"` must be used** for the registration page for the following reasons:

1. **Sensitive Data Protection** — Registration forms collect passwords, email addresses, and personal information. With `GET`, this data would be exposed in the URL (e.g., `register.html?email=user@gmail.com&password=secret123`), making it visible in browser history, server access logs, and to anyone looking at the screen.

2. **No URL Length Restriction** — Registration data can be lengthy. `POST` handles it without truncation issues.

3. **Prevents Duplicate Submissions via Back Button** — Browsers warn users before resubmitting a `POST` form, preventing accidental duplicate account creation.

4. **Standard Security Practice** — Any form that **creates or modifies data** (write operation) must use `POST` — it aligns with REST principles where `POST` represents resource creation.

---

## 2. Semantic HTML

### Why Use `<header>`, `<main>`, `<section>`, and `<footer>` Instead of `<div>`?

While `<div>` is technically capable of structuring an entire webpage, semantic HTML elements are **strongly preferred** for the following reasons:

#### 1. Accessibility (Screen Readers & Assistive Technology)
Semantic tags communicate **meaning and structure** to screen readers (e.g., NVDA, VoiceOver). A blind user navigating with a screen reader can jump directly to `<main>` content or `<nav>` links, skipping repetitive headers. With `<div>` everywhere, the page is a meaningless wall of blocks to assistive tools.

#### 2. SEO (Search Engine Optimization)
Search engine crawlers (Google, Bing) use semantic tags to understand **page hierarchy and content priority**. Content inside `<main>` and `<article>` is weighted more heavily than generic `<div>` wrappers. This directly impacts search ranking.

#### 3. Code Readability and Maintainability
```html
<!-- Hard to read with divs -->
<div class="header">
  <div class="nav">...</div>
</div>
<div class="main-content">
  <div class="section">...</div>
</div>
<div class="footer">...</div>

<!-- Clear and self-documenting with semantic HTML -->
<header>
  <nav>...</nav>
</header>
<main>
  <section>...</section>
</main>
<footer>...</footer>
```
Semantic tags make the document **self-documenting** — any developer reading the code immediately understands the page layout without relying on class names.

#### 4. Browser and Developer Tools
Browsers apply **default meaningful styling** to semantic elements and developer tools display a clearer document outline, making debugging and auditing easier.

#### 5. Future-Proofing and Standards Compliance
Semantic HTML is part of the **HTML5 specification** standard. It ensures compatibility with future browser features, browser reader modes, and web standards.

---

## 3. The Request/Response Cycle

### What Happens When You Type `google.com` and Hit Enter?

The browser goes through a multi-step process involving DNS resolution, TCP/IP networking, and HTTP communication:

#### Step 1: URL Parsing
The browser parses the input `google.com` and determines the protocol (`https://`), the hostname (`google.com`), and the resource path (`/`).

#### Step 2: DNS Resolution (Domain Name System)
The browser needs to translate the human-readable domain name `google.com` into a machine-readable **IP address**.

1. **Browser Cache** — The browser first checks its own DNS cache for a previously resolved IP.
2. **OS Cache** — If not found, the OS checks its local cache and the `hosts` file.
3. **Recursive DNS Resolver** — If still unresolved, the query is sent to the **ISP's DNS resolver**.
4. **Root Name Servers → TLD Servers → Authoritative DNS Server** — The resolver queries the hierarchy:
   - Root server → "who handles `.com`?"
   - TLD server → "who handles `google.com`?"
   - Authoritative DNS server → returns the final **IP address** (e.g., `142.250.185.46`)

#### Step 3: TCP Connection (Three-Way Handshake)
The browser establishes a reliable connection to Google's server at the resolved IP on **port 443** (HTTPS):
1. **SYN** — Browser sends a synchronize packet to the server.
2. **SYN-ACK** — Server acknowledges and responds.
3. **ACK** — Browser confirms, and the connection is established.

#### Step 4: TLS/SSL Handshake (for HTTPS)
Since `google.com` uses HTTPS, an encrypted tunnel is negotiated:
- The server presents its **SSL certificate** to verify its identity.
- Both sides agree on an **encryption algorithm** and exchange keys.
- All subsequent communication is **encrypted**.

#### Step 5: HTTP Request
The browser sends an **HTTP GET request** to the server:
```
GET / HTTP/1.1
Host: google.com
User-Agent: Mozilla/5.0 ...
Accept: text/html
```

#### Step 6: Server Processes the Request
Google's servers receive the request, process it (routing, load balancing, etc.), and prepare an HTTP response with the HTML content of the homepage.

#### Step 7: HTTP Response
The server sends back an **HTTP response**:
```
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
...
<html>...</html>
```

#### Step 8: Browser Renders the Page
The browser receives the HTML and begins **rendering**:
1. Parses HTML → builds the **DOM tree**.
2. Parses CSS → builds the **CSSOM tree**.
3. Combines both into the **Render Tree**.
4. Fetches additional resources (images, JS, fonts) — each triggering the same DNS/TCP/HTTP cycle.
5. Executes JavaScript.
6. **Paints** the final visual page on screen.

#### Summary Diagram:
```
You type google.com
       ↓
Browser checks DNS Cache → OS Cache → ISP Resolver
       ↓
DNS returns IP: 142.250.185.46
       ↓
TCP Three-Way Handshake (SYN → SYN-ACK → ACK)
       ↓
TLS Handshake (encrypt connection)
       ↓
HTTP GET Request sent to server
       ↓
Server returns HTTP 200 OK + HTML
       ↓
Browser renders the page
```
