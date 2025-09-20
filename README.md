# catchall-smtp

PostfixとDovecotを使った「どんな宛先へ送られたものだろうとすべてのEメールをキャッチしてひとつのメールボックスに保存する」例のアーティファクト

メール送信処理を含むシステムの開発に使用する

## メールクライアントの設定

- IMAP
    - localhost:143 TLSなし ID/Pass任意
- SMTP
    - localhost:25 TLSなし 認証なし

## テストメール送信例

```
sendmail -t <<EOF
From: test@example.com
To: johndoe@example.com
Subject: sendmail test

これは sendmail コマンドから送ったテストメールです。
EOF
```
