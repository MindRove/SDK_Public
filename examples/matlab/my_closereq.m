% Informs the main loop the user has closed the figure
function my_closereq(src,event)
    global user_break
    user_break = true;
    delete(gcf);
end