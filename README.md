# email-catchall

[email-catchall ステンシル](../genpack-stencils/email-catchall/)のテスト用アーティファクト。

postfix + dovecot による「宛先を問わずすべてのメールをキャッチしてひとつのメールボックスに保存する」環境を、waypipe SSH 経由の GUI で操作してテストできる。

## テスト手順

### 1. SSH 鍵のセット

VMのシリアルコンソールから `user` でログインし、SSH 公開鍵をセットする。

### 2. GUI 起動

ホストから以下を実行して devlauncher を起動する：

```sh
waypipe ssh user@vsock%$(vm cid email-catchall) devlauncher
```

GUI ランチャーが起動したら **Evolution** メールクライアントを起動する。

### 3. Evolution のアカウント設定

送受信サーバともに以下の設定にする：

| 項目 | 値 |
|------|-----|
| 受信サーバ (IMAP) | localhost |
| ポート | 143 |
| 暗号化 | なし |
| 送信サーバ (SMTP) | localhost |
| ポート | 25 |
| 暗号化 | なし |
| ユーザー名 / パスワード | 何でもよい |

### 4. 動作確認

ランダムな宛先（例: `foo@example.com`、`bar@anydomain.test` など）にメールを送信し、同じメールボックスにループバックして受信されることを確認する。

### 5. トラブルシューティング

問題が発生した場合は devlauncher から **Wireshark** を起動してパケットキャプチャで確認する。
SSH でログインして journalctl でログを確認することもできる：

```sh
ssh root@vsock%$(vm cid email-catchall)
journalctl -u postfix -u dovecot -f
```
