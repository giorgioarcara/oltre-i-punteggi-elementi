#!/usr/bin/env bash
# compile_latex_figures.sh
# Compiles all LaTeX .tex files in subdirectories to PDF,
# then converts each PDF to PNG at 300 dpi.
#
# Usage:
#   ./compile_latex_figures.sh              # process all subdirectories
#   ./compile_latex_figures.sh <subdir>     # process one subdirectory only

FIGURES_DIR="$(cd "$(dirname "$0")" && pwd)"
ERRORS=0

compile_figure() {
    local tex_file="$1"
    local dir
    dir="$(dirname "$tex_file")"
    local base
    base="$(basename "$tex_file" .tex)"

    echo "--- $base  [$(basename "$dir")]"

    if ! (cd "$dir" && pdflatex -interaction=nonstopmode "$base.tex" > /dev/null 2>&1); then
        echo "    [ERROR] pdflatex failed — check: $dir/$base.log"
        ERRORS=$((ERRORS + 1))
        return 1
    fi

    if ! magick -density 300 "$dir/$base.pdf" -quality 90 "$dir/$base.png"; then
        echo "    [ERROR] magick conversion failed"
        ERRORS=$((ERRORS + 1))
        return 1
    fi

    echo "    OK -> $base.png"
}

if [[ $# -eq 1 ]]; then
    while IFS= read -r -d '' tex_file; do
        compile_figure "$tex_file"
    done < <(find "$FIGURES_DIR/$1" -maxdepth 1 -name "*.tex" -print0 | sort -z)
else
    while IFS= read -r -d '' tex_file; do
        compile_figure "$tex_file"
    done < <(find "$FIGURES_DIR" -mindepth 2 -maxdepth 2 -name "*.tex" -print0 | sort -z)
fi

echo ""
if [[ $ERRORS -eq 0 ]]; then
    echo "All figures compiled successfully."
else
    echo "$ERRORS error(s) occurred."
    exit 1
fi
