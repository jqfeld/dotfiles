:GuiTabline 0
if has("unix")
    set guifont=FiraCode\ Nerd\ Font\ Mono:h11
    :GuiRenderLigatures 1
else
    set guifont=FiraCode\ NF:h11
    " For some reason :GuiRenderLigatures does not exist in my Win version of
    " nvim-qt...
end
:GuiPopupmenu 0




