import { Alignment, VerticalAlign } from '@kit.ArkUI'

interface ModuleItem {
  name: string
}

interface TaskItem {
  title: string
  duration: string
}

@Entry
@Component
struct Index {
  @State moduleName: string = 'Module Name'
  @State moduleSummary: string = 'Module Summary'
  @State progressValue: number = 0
  @State focusNote: string = 'Focus Note'

  // Mock data for lists
  private modulesIndexed: Array<ModuleItem> = [
    { name: 'Module 1' },
    { name: 'Module 2' }
  ]

  private tasks: Array<TaskItem> = [
    { title: 'Task 1', duration: '30m' },
    { title: 'Task 2', duration: '45m' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // TabRow Simulation
        Row({ space: 8 }) {
          ForEach(this.modulesIndexed, (item: ModuleItem, index: number) => {
            Button() {
              Text(item.name).fontSize(14).fontColor(index === 0 ? '#C08552' : '#2E251D')
            }.backgroundColor(index === 0 ? '#F3EFE6' : 'transparent').borderRadius(8)
          })
        }

        // HorizontalPager Simulation (Card)
        Column() {
          Column({ space: 8 }) {
            Text(this.moduleName).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#2E251D')
            Text(this.moduleSummary).fontSize(14).fontColor('#2E251D')
            Divider().color('#D4C5B6')
            
            Row({ space: 0 }) {
              Text('Progress').fontSize(12).fontColor('#2E251D')
              Blank()
              Text(`${this.progressValue}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#C08552')
            }.width('100%')

            // Progress Bar
            Stack({ alignContent: Alignment.Start }) {
              Stack({ alignContent: Alignment.Center }) {
                // Background track
                Column().width('100%').height(12).backgroundColor('#E7DDCF').borderRadius(6)
                // Foreground fill
                Column().width(`${this.progressValue}%`).height(12).backgroundColor('#C08552').borderRadius(6)
              }
            }.width('100%').height(12)

            Button() {
              Text('Review outline').fontSize(14).fontColor('#FFFFFF')
            }.backgroundColor('#C08552').borderRadius(8).margin({ top: 8 })
          }.padding(16)
        }.width('100%').backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).margin({ top: 16 })

        // Bottom Row Cards
        Row({ space: 16 }) {
          // Focus Board Card
          Column() {
            Column({ space: 8 }) {
              Text('Focus board').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2E251D')
              
              Column({ space: 4 }) {
                ForEach(this.tasks, (task: TaskItem) => {
                  Column({ space: 2 }) {
                    Text(task.title).fontSize(14).fontColor('#2E251D')
                    Text(task.duration).fontSize(12).fontColor('#9BB1C8')
                  }.padding(8).backgroundColor('#F3EFE6').borderRadius(6)
                })
              }

              Button() {
                Text('Add checkpoint').fontSize(14).fontColor('#FFFFFF')
              }.backgroundColor('#C08552').borderRadius(8).margin({ top: 8 })
            }.padding(12)
          }.layoutWeight(1).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })

          // Reflection Card
          Column() {
            Column({ space: 8 }) {
              Text('Reflection').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2E251D')
              
              Column() {
                Text(this.focusNote).fontSize(14).fontColor('#2E251D')
              }.width('100%').padding(12).backgroundColor('#FFFFFF').borderRadius(8)

              Button() {
                Text('Shuffle note').fontSize(14).fontColor('#FFFFFF')
              }.backgroundColor('#C08552').borderRadius(8).margin({ top: 8 })
            }.padding(12)
          }.layoutWeight(1).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
        }.width('100%')
      }.padding({ left: 16, right: 16, top: 16, bottom: 16 })

      // Top App Bar Simulation
      Row({ space: 0 }) {
        Button() {
          Text('Back').fontSize(14).fontColor('#2E251D')
        }.backgroundColor('transparent')
        
        Blank()
        
        Text('Study Focus Split').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2E251D')
        
        Blank()
        
        Button() {
          Text('Share').fontSize(14).fontColor('#9BB1C8')
        }.backgroundColor('transparent')
      }.width('100%').height(56).padding({ left: 16, right: 16 }).alignItems(VerticalAlign.Center)

      // Bottom Surface Simulation
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Next checkpoint').fontSize(12).fontColor('#2E251D')
            Text('12:40 Studio').fontSize(14).fontColor('#2E251D')
          }
          
          Blank()
          
          Button() {
            Text('Launch session').fontSize(14).fontColor('#FFFFFF')
          }.backgroundColor('#C08552').borderRadius(8)
        }.width('100%').padding({ left: 16, right: 16, top: 8, bottom: 8 }).alignItems(VerticalAlign.Center)
      }.width('100%').backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' })
    }.width('100%').height('100%').backgroundColor('#F3EFE6')
  }
}