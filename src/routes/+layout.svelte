<script>
	import { config } from '$lib/stores';
	import { Toaster } from 'svelte-french-toast';
</script>

<svelte:head>
	<title>Ollama</title>
</svelte:head>
<Toaster />

{#if $config !== undefined}
	<slot />
{/if}
