function sidebarCollapser() {
  const sidebarOpener = document.querySelector('#open-sidebar')
  const sidebarCloser = document.querySelector('#close-sidebar')
  const sidebar = document.querySelector('#side-menu')
  const main = document.querySelector('#main')

  sidebarOpener.addEventListener('click', openSidebar)
  sidebarCloser.addEventListener('click', closeSidebar)

  function openSidebar(e){
    e.preventDefault()
    sidebar.style.width = '250px'
  }

  function closeSidebar(e){
    e.preventDefault()
    sidebar.style.width = '0'
  }
}

export { sidebarCollapser }