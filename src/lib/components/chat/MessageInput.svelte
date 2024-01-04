<script lang="ts">
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
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 20 20"
						fill="currentColor"
						class="w-5 h-5"
					>
						<path
							fill-rule="evenodd"
							d="M10 3a.75.75 0 01.75.75v10.638l3.96-4.158a.75.75 0 111.08 1.04l-5.25 5.5a.75.75 0 01-1.08 0l-5.25-5.5a.75.75 0 111.08-1.04l3.96 4.158V3.75A.75.75 0 0110 3z"
							clip-rule="evenodd"
						/>
					</svg>
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
								if (e.keyCode == 13 && !e.shiftKey) {
									e.preventDefault();
								}
								if (prompt !== "" && e.keyCode == 13 && !e.shiftKey) {
									submitPrompt(prompt);
								}
							}}
							rows="1"
							on:input={(e) => {
								e.target.style.height = "";
								e.target.style.height = Math.min(e.target.scrollHeight, 200) + "px";
							}}
						/>

						<div class="self-end mb-2 flex space-x-0.5 mr-2">
							{#if messages.length == 0 || messages.at(-1).done == true}
								<button
									class="{prompt !== ''
										? 'bg-black text-white hover:bg-gray-900 dark:bg-white dark:text-black dark:hover:bg-gray-100 '
										: 'text-white bg-gray-100 dark:text-gray-800 dark:bg-gray-600 disabled'} transition rounded-lg p-1 mr-0.5 w-7 h-7 self-center"
									type="submit"
									disabled={prompt === ""}
								>
									<svg
										xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 20 20"
										fill="currentColor"
										class="w-5 h-5"
									>
										<path
											fill-rule="evenodd"
											d="M10 17a.75.75 0 01-.75-.75V5.612L5.29 9.77a.75.75 0 01-1.08-1.04l5.25-5.5a.75.75 0 011.08 0l5.25 5.5a.75.75 0 11-1.08 1.04l-3.96-4.158V16.25A.75.75 0 0110 17z"
											clip-rule="evenodd"
										/>
									</svg>
								</button>
							{:else}
								<button
									class="bg-white hover:bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-800 transition rounded-lg p-1.5"
									on:click={stopResponse}
								>
									<svg
										xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 24 24"
										fill="currentColor"
										class="w-5 h-5"
									>
										<path
											fill-rule="evenodd"
											d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12zm6-2.438c0-.724.588-1.312 1.313-1.312h4.874c.725 0 1.313.588 1.313 1.313v4.874c0 .725-.588 1.313-1.313 1.313H9.564a1.312 1.312 0 01-1.313-1.313V9.564z"
											clip-rule="evenodd"
										/>
									</svg>
								</button>
							{/if}
						</div>
					</div>
				</form>

				<div class="mt-1.5 text-xs text-gray-500 text-center">
					LLMs can make mistakes. Verify important information.
				</div>
			</div>
		</div>
	</div>
</div>
