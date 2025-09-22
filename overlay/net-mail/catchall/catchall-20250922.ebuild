EAPI=8

SLOT="0"
KEYWORDS="amd64 x86 arm64 riscv"

S="${WORKDIR}"

RDEPEND="
    mail-mta/postfix
    net-mail/dovecot
"

src_install() {
    default
    exeinto /usr/lib/genpack/package-scripts/${CATEGORY}/${PN}
    doexe ${FILESDIR}/setup-catchall.sh
}
