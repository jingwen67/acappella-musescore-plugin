const fs=require('node:fs'),vm=require('node:vm'),assert=require('node:assert/strict'),path=require('node:path');
const folder=path.join(__dirname,'..');
function load(name,bindings={}){const context={...bindings};vm.createContext(context);vm.runInContext(fs.readFileSync(path.join(folder,name),'utf8').replace(/^\.(pragma|import).*$/gm,''),context);return context;}
const native=load('NativeInstruments.js'),template=load('Template.js',{NativeInstruments:native}),range=load('RangeScan.js');
const options={title:'New Song',arranger:'Jingwen',bars:32,beats:4,beatType:4,fifths:0,tempo:100,solos:[{clef:'treble'},{clef:'bass'}],soprano:true,alto:true,tenor:true,baritone:true,bass:true,beatbox:true,rap:false};
const voices=template.voices(options);
assert.deepEqual(Array.from(voices.slice(0,2),v=>v.name),['Solo 1','Solo 2']);
assert.equal(voices[1].clef,'F');assert.equal(voices.find(v=>v.name==='Tenor').octave,-1);
assert.ok(voices.filter(v=>v.name!=='Beatbox').every(v=>v.sound==='keyboard.piano'));
const xml=template.buildNative(options);assert.ok(xml.includes('New Song'));assert.ok(xml.includes('Baritone'));
for(const profile of Object.keys(range.limits)){
 const rule=range.limits[profile];assert.equal(range.outOfRange(rule.low,rule),false);assert.equal(range.outOfRange(rule.low-1,rule),true);
 if(rule.high!==null){assert.equal(range.outOfRange(rule.high,rule),false);assert.equal(range.outOfRange(rule.high+1,rule),true);}
}
assert.equal(range.classify('Solo 2','alto'),range.limits.alto);assert.equal(range.classify('Solo 1','bass'),range.limits.bass);
assert.equal(range.classify('Beatbox'),null);assert.equal(range.classify('Rap'),null);
const a={note:{pitch:80,color:'#123456'},key:'a',rule:range.limits.soprano},b={note:{pitch:80,color:range.markerColor},key:'b',rule:range.limits.alto};
let result=range.plan([a],{},'check',()=>false);assert.equal(result.edits[0].color,range.markerColor);assert.equal(result.marks.a,'#123456');
a.note.color=range.markerColor;a.note.pitch=60;result=range.plan([a],result.marks,'check',()=>false);assert.equal(result.edits[0].color,'#123456');
result=range.plan([a,b],{a:'#123456',b:'#654321'},'clear',item=>item.key==='a');assert.equal(result.edits.length,1);assert.equal(result.marks.b,'#654321');
const qml=fs.readFileSync(path.join(folder,'AcappellaTemplate.qml'),'utf8');
assert.equal((qml.match(/TabButton\s*\{/g)||[]).length,2);
assert.ok(!/BassScore|BassHarmony|PatternScore|bassRead|refreshBassSources/.test(qml));
for(const match of qml.matchAll(/import "([^"]+\.js)" as/g))assert.ok(fs.existsSync(path.join(folder,match[1])));
console.log('PASS retained template defaults, multiple Solo clefs, range boundaries, independent Solo profiles, color restoration, selection clearing and two-tab dependency closure.');
