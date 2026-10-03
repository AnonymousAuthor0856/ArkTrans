@Entry
@Component
struct Index {
  @State notes: NoteItem[] = [
    { title: "Today's first note", content: "Thought of it this morning, jotting it down" },
    { title: "Weekend shopping list", content: "Milk, eggs, bread, butter, cheese, apples, bananas" },
    { title: "Meeting minutes — Q3 planning", content: "Discussed roadmap, next quarter focus on search and sync" },
    { title: "Book notes", content: "Atomic Habits — improve 1% every day, that's 37x in a year" },
    { title: "Workout plan", content: "Monday chest + triceps, Wednesday back + biceps, Friday legs + shoulders" }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (Notes List) ===
      Column() {
        // Top Bar
        Row() {
          Image($r('app.media.startIcon')).width(24).height(24).margin({ right: 16 })
          Text('Notes').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#191D19')
          Blank()
          Image($r('app.media.startIcon')).width(24).height(24).margin({ right: 16 })
          Image($r('app.media.startIcon')).width(24).height(24).margin({ right: 16 })
          Image($r('app.media.startIcon')).width(24).height(24)
        }.width('100%').height(56).padding({ left: 16, right: 16 }).alignItems(VerticalAlign.Center)

        // List
        List({ space: 8 }) {
          ForEach(this.notes, (item: NoteItem) => {
            ListItem() {
              Column() {
                Text(item.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#191D19')
                Blank().height(4)
                Text(item.content).fontSize(14).fontColor('#424940').maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })
              }.padding(16)
            }.width('100%')
          }, (item: NoteItem) => item.title)
        }.layoutWeight(1).padding({ left: 16, right: 16 })
      }.width('100%').height('100%').backgroundColor('#F8FBF1')

      // === FloatingActionButton ===
      Button() {
        Image($r('app.media.startIcon')).width(24).height(24)
      }.width(56).height(56).borderRadius(16).backgroundColor('#D7F5D9').shadow({ radius: 6, color: '#3F000000' }).margin(24)
    }.width('100%').height('100%')
  }
}

interface NoteItem {
  title: string;
  content: string;
}