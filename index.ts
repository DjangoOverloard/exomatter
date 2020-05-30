import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp()


export const createPost = functions.https.onRequest(async(req, res)=>{
    const obj = req.body;
    await admin.firestore().collection('Posts').doc().create({
        'time': admin.firestore.Timestamp.now(),
        'title': obj.title,
        'description': obj.description, 
        'tags': ['breakfast', ],
        'userId': 'lkasdfl;kjasdf;kljasd;fkj',
        'nickname': 'starman', 
        'upvotes': [], 
        'downvotes': [],
        'repetitionReports': 0,  
    }).then().catch();
    res.send('done');
});

function padL(input:any){
    if(input.length == 1){
        return '0'+ input.toString();
    }else{
        return input.toString(); 
    }
}

const tags = ['breakfast', 'workout', 'lunch', 'productivity technique', 'dinner', 'new skill', 'entertainment'];
export const makeScheduleHttpFunction = functions.https.onRequest(async(req, res)=>{
    let promises:Array<Promise<any>> = [];
    const time = Math.round(admin.firestore.Timestamp.now().toMillis()/1000)- 1200;
    let t = new Date(1970, 0, 1); // Epoch
    t.setSeconds(time);
    const displayTime = padL(t.getDay)+'/' +padL(t.getMonth);
    const schedulePayload:{[k: string]: any}= {
        'time': time,
        'displayTime': displayTime, 
        'tags': [],
        'activities': [],
        'links': [],
        'credits': [],
        'upvotes': [],
        'downvotes': [],
    };
    tags.forEach(async(tag)=>{
        const promise = admin.firestore().collection('Posts')
        .where('time', "<=", time).where('tags','array-contains',tag).orderBy('upvotes',"desc")
        .limit(1).get()
        .then((docs)=>{
            if(docs.docs.findIndex(doc => !doc.exists) !== -1){
                return null;
            }else{
                const ds = docs.docs[0];
                schedulePayload['links'].add(ds.id);
                schedulePayload['tags'].add(tag);
                const data = ds.data();
                schedulePayload['credits'].add(data.nickname);
                schedulePayload['activities'].add(data.title);
                return ds;
            }
        }).catch();
        promises.push(promise);
    });
    await Promise.all(promises);
    res.send(schedulePayload);
    // if(docs.length!=0){
    //     await admin.firestore().collection('Schedules').doc().set(schedulePayload);
    // }
    res.send('done with everyday function');
});

export const createSchedule = functions.https.onRequest(async(req, res)=>{
    await admin.firestore().collection('Schedules').doc().create({
        'time': admin.firestore.Timestamp.now(),
        'activities': [
            'French toast with tomatoes',
            'Chinese power exercise',
            'Zharkoe s myasom',
            '25 then 5',
            'Tasty macburger',
            'Juggling',
            'Watch boku no piku',
        ],
        'tagNames': [
            'breakfast',   
            'workout', 
            'lunch',       
            'productivity technique', 
            'dinner', 
            'new skill',
            'entertainment', 
         ],
        'links': [
            ';ksjdfpoijasdf;lkjasdf',
            'asdflkjasd;lfkjasdf',
            'askjfa;kfja;kdf',
            'asd;fkjasd;lfkjas;df',
            'asldfkjas;dkfjasdf',
            'asd;kfljas;dkfja;d',
        ],
        'upvotes': [],
        'downvotes': [],
    });
    res.send('done here');
});

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
