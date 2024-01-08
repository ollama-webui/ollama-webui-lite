<script lang="ts">
	import Icon from "../common/Icon.svelte";

	export let submitPrompt: Function;
	export let stopResponse: Function;

	export let autoScroll = true;
	export let prompt = "";
	export let messages = [];
</script>

<div class="fixed bottom-0 w-full">
	<div class="px-2.5 pt-2.5 -mb-0.5 mx-auto inset-x-0 bg-transparent flex justify-center">
		{#if autoScroll === false && messages.length > 0}
			<div class=" flex justify-center mb-4">
				<button
					class=" bg-white border border-gray-100 dark:border-none dark:bg-white/20 p-1.5 rounded-full"
					on:click={() => {
						autoScroll = true;
						window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
					}}
				>
					
				</button>
			</div>
		{/if}
	</div>
	<div class="bg-white dark:bg-gray-800">
		<div class="max-w-3xl px-2.5 -mb-0.5 mx-auto inset-x-0">
			<div class="bg-gradient-to-t from-white dark:from-gray-800 from-40% pb-2">
				<form
					class=" flex flex-col relative w-full rounded-xl border dark:border-gray-600 bg-white dark:bg-gray-800 dark:text-gray-100"
					on:submit|preventDefault={() => {
						submitPrompt(prompt);
					}}
				>
					<div class=" flex">
						<textarea
							id="chat-textarea"
							class=" dark:bg-gray-800 dark:text-gray-100 outline-none w-full py-3 px-2 pl-4 rounded-xl resize-none"
							placeholder="Send a message"
							bind:value={prompt}
							on:keypress={(e) => {
								if (e.key == "Enter" && !e.shiftKey) {
									e.preventDefault();
								}
								if (prompt !== "" && e.key == "Enter" && !e.shiftKey) {
									submitPrompt(prompt);
								}
							}}
							rows="1"
							on:input={(e) => {
                if (e && e.target && e.target instanceof HTMLTextAreaElement) {
                  e.target.style.height = "auto";
								  e.target.style.height = `${Math.min(e.target.scrollHeight, 200)}px`;
                }
							}}
						/>

						<div class="self-end mb-2 flex space-x-0.5 mr-2">
							{#if messages.length == 0 || messages.at(-1).done}
								<button
									class="{prompt !== ''
										? 'bg-black text-white hover:bg-gray-900 dark:bg-white dark:text-black dark:hover:bg-gray-100 '
										: 'text-white bg-gray-100 dark:text-gray-800 dark:bg-gray-600 disabled'} transition rounded-lg p-1 mr-0.5 w-7 h-7 self-center"
									type="submit"
									disabled={prompt === ""}
								>
									<Icon name="arrow"/>
								</button>
							{:else}
								<button
									class="bg-white hover:bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-800 transition rounded-lg p-1.5"
									on:click={stopResponse}
								>
                  <Icon name="stop"/>
								</button>
							{/if}
						</div>
					</div>
				</form>

				<p class="mt-1.5 text-xs text-gray-500 text-center">
					LLMs can make mistakes. Verify important information.
        </p>
			</div>
		</div>
	</div>
</div>
