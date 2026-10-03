@Entry
@Component
struct Index {
  @State isChecked: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === BotanyContent (LazyColumn) ===
      List() {
        ListItem() {
          Column({ space: 0 }) {
            Text('Good Morning,').fontColor('#757575')
            Text('My Jungle').fontWeight(FontWeight.Bold).letterSpacing(-1).fontColor('#212121')
          }.padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }

        ListItem() {
          // SectionHeader: Pending Tasks
          Text('Pending Tasks').fontWeight(FontWeight.Bold).fontColor('#212121')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }

        ListItem() {
          // LazyRow: TaskCard
          List({ space: 16 }) {
            ListItem() {
              // TaskCard
              Column() {
                Column({ space: 0 }) {
                  Row({ space: 0 }) {
                    // Checkbox Icon Box
                    Stack({ alignContent: Alignment.Center }) {
                      Image($r('app.media.startIcon')).width(20).height(20)
                        .objectFit(ImageFit.Contain)
                        .borderRadius(20)
                    }.width(40).height(40).borderRadius(20)
                      .backgroundColor(this.isChecked ? '#8BC34A' : '#FFFFFF')
                  }.width('100%')

                  Column({ space: 0 }) {
                    Text('task.title').fontWeight(FontWeight.Bold).fontColor('#212121')
                    Text('task.plantName').fontColor('#757575').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                    Blank().height(8)
                    
                    // Urgency/Done Badge
                    Stack({ alignContent: Alignment.Center }) {
                      Text(this.isChecked ? "DONE" : "Urgent").fontWeight(FontWeight.Bold).fontColor(this.isChecked ? '#FFFFFF' : '#212121')
                    }.padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4)
                      .backgroundColor(this.isChecked ? '#8BC34A' : '#E0E0E0')
                  }
                }.width('100%').height('100%').padding(16)
              }.width(160).height(180).backgroundColor('#FFFFFF').borderRadius(24)
                .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
          }.listDirection(Axis.Horizontal).padding({ left: 24, right: 24 })
        }

        ListItem() {
          Column() {
            Blank().height(32)
          }
        }

        ListItem() {
          // SectionHeader: Your Collection
          Text('Your Collection').fontWeight(FontWeight.Bold).fontColor('#212121')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }

        ListItem() {
          // PlantListItem
          Row({ space: 0 }) {
            // Icon Box
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
            }.width(56).height(56).borderRadius(12).backgroundColor('#EEEEEE')

            Blank().width(16)

            // Info Column
            Column({ space: 0 }) {
              Text('plant.name').fontWeight(FontWeight.Bold).fontColor('#212121')
              Text('plant.scientificName').fontStyle(FontStyle.Italic).fontColor('#757575')
              Blank().height(8)
              
              Row({ space: 0 }) {
                Image($r('app.media.startIcon')).width(12).height(12).objectFit(ImageFit.Contain)
                Blank().width(4)
                Text('plant.location').fontColor('#757575')
              }.alignItems(VerticalAlign.Center)
            }.layoutWeight(1)

            // Water Status Column
            Column({ space: 0 }) {
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              Text('Water').fontWeight(FontWeight.Bold).fontColor('#8BC34A')
              Text('0 days').fontColor('#757575')
            }.alignItems(HorizontalAlign.End)
          }.alignItems(VerticalAlign.Center).width('100%').padding(16).backgroundColor('#FAFAFA').borderRadius(16)
        }
      }.width('100%').height('100%').backgroundColor('#FFFFFF')

      // === BotanyTopBar ===
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.type(ButtonType.Circle).backgroundColor('#F5F5F5').width(40).height(40)
        
        Blank().layoutWeight(1)

        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.type(ButtonType.Circle).backgroundColor('#F5F5F5').width(40).height(40)
      }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 24, left: 24, right: 24, bottom: 8 })

      // === FloatingActionButton ===
      Button() {
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.type(ButtonType.Circle).backgroundColor('#212121').width(56).height(56)
        .position({ x: 'calc(100% - 80vp)', y: 'calc(100% - 140vp)' })

      // === BotanyBottomBar ===
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.type(ButtonType.Normal).backgroundColor('Transparent')
        
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.type(ButtonType.Normal).backgroundColor('Transparent')
        
        Blank().width(32)
        
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.type(ButtonType.Normal).backgroundColor('Transparent')
        
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.type(ButtonType.Normal).backgroundColor('Transparent')
      }.alignItems(VerticalAlign.Center).width('100%').backgroundColor('#FFFFFF').padding({ left: 48, right: 48, top: 24, bottom: 24 })
        .position({ x: 0, y: 'calc(100% - 96vp)' })
    }.width('100%').height('100%')
  }
}