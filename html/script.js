window.addEventListener('message', (event) => {
    const data = event.data;
    if (data.action === 'abrirMenu') {
        document.getElementById('menu').classList.remove('hidden');
    } else if (data.action === 'fecharMenu') {
        document.getElementById('menu').classList.add('hidden');
    }
});

function selecionarAndar(andar) {
    fetch(`https://${GetParentResourceName()}/escolherAndar`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ andar: andar })
    });

    document.getElementById('menu').classList.add('hidden');
    fetch(`https://${GetParentResourceName()}/fecharMenu`, {
        method: 'POST'
    });
}
