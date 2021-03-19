const Clipboard = (str)=> {
    console.log(str);
    navigator.clipboard.writeText(str);
    return;
}
export default Clipboard;