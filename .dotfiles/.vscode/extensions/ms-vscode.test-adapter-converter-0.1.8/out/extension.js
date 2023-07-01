"use strict";var P=Object.create;var T=Object.defineProperty;var D=Object.getOwnPropertyDescriptor;var U=Object.getOwnPropertyNames;var H=Object.getPrototypeOf,F=Object.prototype.hasOwnProperty;var L=(r,e)=>()=>(e||r((e={exports:{}}).exports,e),e.exports),W=(r,e)=>{for(var t in e)T(r,t,{get:e[t],enumerable:!0})},S=(r,e,t,s)=>{if(e&&typeof e=="object"||typeof e=="function")for(let o of U(e))!F.call(r,o)&&o!==t&&T(r,o,{get:()=>e[o],enumerable:!(s=D(e,o))||s.enumerable});return r};var f=(r,e,t)=>(t=r!=null?P(H(r)):{},S(e||!r||!r.__esModule?T(t,"default",{value:r,enumerable:!0}):t,r)),j=r=>S(T({},"__esModule",{value:!0}),r);var E=L(v=>{"use strict";Object.defineProperty(v,"__esModule",{value:!0});v.testExplorerExtensionId=void 0;v.testExplorerExtensionId="hbenl.vscode-test-explorer"});var G={};W(G,{activate:()=>z});module.exports=j(G);var p=f(require("vscode")),x=f(E());var u=f(require("vscode")),k="promptedToUseNative",B=!1,I="testExplorer.useNativeTesting",C=()=>!!u.workspace.getConfiguration().get(I,!1),g=(r=u.ConfigurationTarget.Global)=>{u.workspace.getConfiguration().update(I,!0,r),u.window.showInformationMessage('Thanks for taking native testing for a spin! If you run into problems, you can turn the new experience off with the "testExplorer.useNativeTesting" setting.')};var m=class{constructor(e){this.context=e}registerTestAdapter(e){this.shouldPrompt()&&e.testStates(t=>{t.type==="started"&&this.promptToUseNativeTesting()})}unregisterTestAdapter(){}shouldPrompt(){return!B&&!C()&&!this.context.globalState.get(k)}async promptToUseNativeTesting(){if(!this.shouldPrompt())return;let e="Yes",t="Only in this Workspace",s="No";B=!0;let o=await u.window.showInformationMessage("Would you like to try out VS Code's new native UI for testing?",s,e,t);o&&(o===e?g(u.ConfigurationTarget.Global):o===t?g(u.ConfigurationTarget.Workspace):o===s&&this.context.globalState.update(k,!0))}};var N=f(require("vscode"));var i=f(require("vscode")),w=new WeakMap,K=(r,e)=>{let t=new Set;return r.filter(s=>{let o=e(s);return t.has(o)?!1:(t.add(o),!0)})},O="workbench.view.extension.test",_=1,y=class{constructor(e){this.adapter=e;this.itemsById=new Map;this.tasksByRunId=new Map;this.runningSuiteByRunId=new Map;this.disposables=[];this.controller=i.tests.createTestController(`test-adapter-ctrl-${_++}`,""),this.controller.refreshHandler=()=>this.adapter.load(),this.disposables.push(this.controller);let t=s=>(o,n)=>{if(!o.include){this.run(this.controller.createTestRun(o),o.include,s,n);return}let a=new Map;for(let d of o.include){let l=w.get(d).converter,c=a.get(l);c?c.push(d):a.set(l,[d])}for(let[d,l]of a)d.run(this.controller.createTestRun(o),l,s,n)};this.controller.createRunProfile("Run",i.TestRunProfileKind.Run,t(!1),!0),this.controller.createRunProfile("Debug",i.TestRunProfileKind.Debug,t(!0),!0),this.disposables.push(e.tests(s=>{var o;switch(s.type){case"finished":(o=this.doneDiscovery)==null||o.call(this),this.doneDiscovery=void 0,this.itemsById.clear(),this.syncTopLevel(s);break;case"started":this.doneDiscovery||i.window.withProgress({title:"An adapter is discovering tests",location:{viewId:O}},()=>new Promise(n=>{this.doneDiscovery=n,setTimeout(n,3e4)}));break}}),e.testStates(s=>{var n,a;let o=this.tasksByRunId.get((n=s.testRunId)!=null?n:"");if(o)switch(s.type){case"test":return this.onTestEvent(o,s);case"suite":return this.onTestSuiteEvent(s);case"finished":return this.tasksByRunId.delete((a=s.testRunId)!=null?a:""),o.end()}}))}get controllerId(){return this.controller.id}dispose(){this.disposables.forEach(e=>e.dispose())}async run(e,t,s,o){if(!this.controller)return;t||(t=A(this.controller.items));let n=this.adapter.testStates(a=>{var l,c;if(a.type!=="started")return;let d=[t];for(;d.length;)for(let h of d.pop())(l=w.get(h))!=null&&l.isSuite||e.enqueued(h),d.push(A(h.children));this.tasksByRunId.set((c=a.testRunId)!=null?c:"",e),o.onCancellationRequested(()=>this.adapter.cancel()),n.dispose()});s?this.adapter.debug?this.adapter.debug(t.map(a=>a.id)):n.dispose():this.adapter.run(t.map(a=>a.id))}syncTopLevel(e){if(i.commands.executeCommand("setContext","hasTestConverterTests",!0),e.suite)this.controller.label=this.adapter.workspaceFolder?`${this.adapter.workspaceFolder.name} - ${e.suite.label}`:e.suite.label,this.syncItemChildren(this.controller.items,e.suite.children);else if(e.errorMessage){let t=this.controller.createTestItem("error","Test discovery failed");t.error=e.errorMessage,this.controller.items.replace([t])}}syncItemChildren(e,t,s){e.replace(K(t,o=>o.id).map(o=>this.createTest(o,s)))}createTest(e,t){let s=this.controller.createTestItem(e.id,e.label,e.file?M(e.file):t);return w.set(s,{isSuite:e.type==="suite",converter:this}),this.itemsById.set(e.id,s),s.description=e.description,e.line!==void 0&&(s.range=new i.Range(e.line,0,e.line+1,0)),e.errored&&(s.error=e.message),"children"in e&&this.syncItemChildren(s.children,e.children),s}onTestSuiteEvent(e){var n;let t=(n=e.testRunId)!=null?n:"",s=this.runningSuiteByRunId.get(t),o=typeof e.suite=="string"?e.suite:e.suite.id;e.state==="running"?(!this.itemsById.has(o)&&typeof e.suite=="object"&&s&&s.children.add(this.createTest(e.suite)),this.itemsById.has(o)&&this.runningSuiteByRunId.set(t,this.itemsById.get(o))):s&&s.id===o&&(s.parent?this.runningSuiteByRunId.set(t,s.parent):this.runningSuiteByRunId.delete(t))}onTestEvent(e,t){var a,d;let s=this.runningSuiteByRunId.get((a=t.testRunId)!=null?a:""),o=typeof t.test=="string"?t.test:t.test.id;t.state==="running"&&!this.itemsById.has(o)&&typeof t.test=="object"&&s&&s.children.add(this.createTest(t.test));let n=this.itemsById.get(o);if(n){switch(t.state){case"skipped":e.skipped(n);break;case"running":e.started(n);break;case"passed":e.passed(n);break;case"errored":case"failed":let l=[];if(t.message){let c=new i.TestMessage(t.message);l.push(c)}for(let c of(d=t.decorations)!=null?d:[]){let h=new i.TestMessage(c.message),R=c.file?M(c.file):n.uri;R&&(h.location=new i.Location(R,new i.Position(c.line,0))),l.push(h)}e[t.state](n,l);break}t.message&&(t.state!=="errored"&&t.state!=="failed"||!n.uri)&&e.appendOutput(t.message.replace(/\r?\n/g,`\r
`))}}},A=r=>{let e=[];return r.forEach(t=>e.push(t)),e},$=/^[a-z][a-z0-9+-.]+:/,M=r=>$.test(r)?i.Uri.parse(r):i.Uri.file(r);var b=class{constructor(){this.converters=new Map}registerTestAdapter(e){this.converters.set(e,new y(e))}unregisterTestAdapter(e){var t;(t=this.converters.get(e))==null||t.dispose(),this.converters.delete(e)}dispose(){for(let e of this.converters.values())e.dispose();N.commands.executeCommand("setContext","hasTestConverterTests",!1)}};function z(r){let e,t=new m(r);p.env.appName.toLowerCase().includes("insiders")&&t.shouldPrompt()&&setTimeout(()=>{var o;let s=(o=p.extensions.getExtension(x.testExplorerExtensionId))==null?void 0:o.exports;s&&(s.registerTestController(t),r.subscriptions.push({dispose(){s.unregisterTestController(t)}}))},2e3),r.subscriptions.push(p.commands.registerCommand("testExplorerConverter.activate",()=>{var o;let s=(o=p.extensions.getExtension(x.testExplorerExtensionId))==null?void 0:o.exports;s&&(e=new b,r.subscriptions.push(e),s.registerTestController(e),r.subscriptions.push({dispose(){s.unregisterTestController(e)}}))}),p.workspace.onDidChangeConfiguration(s=>{s.affectsConfiguration(I)&&(C()||(e==null||e.dispose(),e=void 0))}),p.commands.registerCommand("testExplorerConverter.useNativeTesting",()=>g()))}0&&(module.exports={activate});
