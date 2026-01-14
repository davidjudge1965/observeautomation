(() => {
  function qs(id) { return document.getElementById(id); }
  const toggle = qs('vapi-toggle');
  const panel = qs('vapi-panel');
  const root = qs('vapi-chatbot');
  const close = qs('vapi-close');
  const form = qs('vapi-form');
  const input = qs('vapi-input');
  const messages = qs('vapi-messages');

  if (!toggle || !panel || !root) return;

  function addMessage(text, who='bot'){
    const el = document.createElement('div');
    el.className = 'vapi-msg ' + (who === 'user' ? 'user' : 'bot');
    el.textContent = text;
    messages.appendChild(el);
    messages.scrollTop = messages.scrollHeight;
  }

  function setOpen(open){
    if(open){ root.classList.remove('vapi-collapsed'); root.classList.add('vapi-panel-open'); root.setAttribute('aria-hidden','false'); input.focus(); }
    else { root.classList.remove('vapi-panel-open'); root.classList.add('vapi-collapsed'); root.setAttribute('aria-hidden','true'); }
  }

  toggle.addEventListener('click', ()=> setOpen(true));
  close && close.addEventListener('click', ()=> setOpen(false));

  form.addEventListener('submit', async (e) =>{
    e.preventDefault();
    const text = input.value && input.value.trim();
    if(!text) return;
    addMessage(text,'user');
    input.value = '';

    const cfg = window.VAPI_CONFIG || {};
    const endpoint = cfg.endpoint;
    const key = cfg.key;

    if(!endpoint){
      addMessage('No VAPI endpoint configured. Set site.Params.vapi.endpoint in your config.','bot');
      return;
    }

    try{
      const res = await fetch(endpoint, {
        method: 'POST',
        headers: Object.assign({'Content-Type':'application/json'}, key ? {'Authorization': 'Bearer ' + key} : {}),
        body: JSON.stringify({message: text})
      });
      let reply = '';
      try{ const j = await res.json(); reply = j.reply || j.output || JSON.stringify(j); } catch(e){ reply = await res.text(); }
      addMessage(reply || '(no reply)','bot');
    }catch(err){
      addMessage('Error: ' + (err.message || err),'bot');
    }
  });

})();
