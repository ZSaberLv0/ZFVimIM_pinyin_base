let s:repoPath=expand('<sfile>:p:h:h')
function! s:dbInit()
    let repoPath = s:repoPath
    let dbFile = '/misc/pinyin.txt'
    let dbCountFile = '/misc/pinyin_count.txt'

    let db = ZFVimIM_dbInit({
                \   'name' : 'pinyin',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'git',
                \   'dbId' : db['dbId'],
                \   'repoPath' : repoPath,
                \   'dbFile' : dbFile,
                \   'dbCountFile' : dbCountFile,
                \   'gitUserEmail' : get(g:, 'ZFVimIM_pinyin_gitUserEmail', get(g:, 'zf_git_user_email', '')),
                \   'gitUserName' : get(g:, 'ZFVimIM_pinyin_gitUserName', get(g:, 'zf_git_user_name', '')),
                \   'gitUserToken' : get(g:, 'ZFVimIM_pinyin_gitUserToken', get(g:, 'zf_git_user_token', '')),
                \ })
endfunction

augroup ZFVimIM_pinyin_augroup
    autocmd!
    autocmd User ZFVimIM_event_OnDbInit call s:dbInit()
augroup END

