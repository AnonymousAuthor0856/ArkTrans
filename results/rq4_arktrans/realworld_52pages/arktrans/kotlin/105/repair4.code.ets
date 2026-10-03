@Entry
@Component
struct Index {
  @State dateText: string = 'Today'
  @State title: string = "Today's first note"
  @State content: string = 'Thought of it this morning, jotting it down.\nThere are quite a few things to do today...'
  @State checked: boolean = false
  @State listItem: string = ''
  @State showOverflow: boolean = false
  @State showDeleteDialog: boolean = false
  @State showLinkDialog: boolean = false
  @State linkUrl: string = ''

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column() {
        // Date Text
        Text(this.dateText)
          .fontSize(14)
          .fontColor('#424940')
          .width('100%')
          .padding({ top: 8, bottom: 8 })

        // Title Input
        TextInput({ placeholder: 'Title', text: this.title })
          .type(InputType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#191D19')
          .width('100%')
          .onChange((value: string) => {
            this.title = value
          })

        Blank().height(12)

        // Content Input
        TextInput({ placeholder: 'Start writing...', text: this.content })
          .type(InputType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .fontSize(16)
          .fontColor('#191D19')
          .width('100%')
          .layoutWeight(1)
          .onChange((value: string) => {
            this.content = value
          })

        // List Section (Hidden in screenshot but part of structure)
        List({ space: 8 }) {
          ListItem() {
            Row() {
              Checkbox({ name: 'cb', group: 'g1', isChecked: this.checked })
                .width(24)
                .height(24)
              
              TextInput({ placeholder: 'List item', text: this.listItem })
                .type(InputType.Normal)
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .fontSize(16)
                .fontColor('#191D19')
                .layoutWeight(1)
                .onChange((value: string) => {
                  this.listItem = value
                })

              Button()
                .type(ButtonType.Circle)
                .width(36)
                .height(36)
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  this.listItem = ''
                })
                .child(Image($r('app.media.startIcon')).width(18).height(18))
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }
          
          ListItem() {
            Button()
              .type(ButtonType.Capsule)
              .backgroundColor(Color.Transparent)
              .width('100%')
              .height(40)
              .child(Row() {
                Image($r('app.media.startIcon')).width(18).height(18)
                Blank().width(4)
                Text('Add item').fontColor('#424940')
              }.alignItems(VerticalAlign.Center))
          }
        }
        .width('100%')
        .visibility(Visibility.None) // Hidden based on screenshot state

        Blank().height(8)

        // Chips Row
        Row({ space: 8 }) {
          // Label Chip
          Button()
            .type(ButtonType.Capsule)
            .backgroundColor('#E8DEF8')
            .width('auto')
            .height(32)
            .child(Text('Work').fontColor('#1D192B').fontSize(12).padding({ left: 12, right: 12 }))

          // Reminder Chip
          Button()
            .type(ButtonType.Capsule)
            .backgroundColor('#FFD8E4')
            .width('auto')
            .height(32)
            .child(Row() {
              Image($r('app.media.startIcon')).width(16).height(16)
              Blank().width(4)
              Text('Reminder').fontColor('#31111D').fontSize(12)
            }.alignItems(VerticalAlign.Center).padding({ left: 12, right: 12 }))
        }
        .width('100%')

        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F8FBF1')

      // === Top App Bar ===
      Row() {
        // Back Icon
        Button()
          .type(ButtonType.Circle)
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
          .child(Image($r('app.media.startIcon')).width(24).height(24))

        // Title
        Text('Edit Note')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#191D19')
          .margin({ left: 8 })

        Blank().layoutWeight(1)

        // Pin Icon
        Button()
          .type(ButtonType.Circle)
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
          .child(Image($r('app.media.startIcon')).width(24).height(24))

        // Alarm Icon
        Button()
          .type(ButtonType.Circle)
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
          .child(Image($r('app.media.startIcon')).width(24).height(24))

        // Label Icon
        Button()
          .type(ButtonType.Circle)
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
          .child(Image($r('app.media.startIcon')).width(24).height(24))

        // More Icon & Dropdown
        Stack({ alignContent: Alignment.TopEnd }) {
          Button()
            .type(ButtonType.Circle)
            .width(48)
            .height(48)
            .backgroundColor(Color.Transparent)
            .child(Image($r('app.media.startIcon')).width(24).height(24))
            .onClick(() => {
              this.showOverflow = !this.showOverflow
            })

          if (this.showOverflow) {
            Column() {
              // Convert to List
              Button()
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .width('100%')
                .height(48)
                .child(Row() {
                  Text('Convert to List').fontColor('#191D19').layoutWeight(1)
                  Image($r('app.media.startIcon')).width(20).height(20)
                }.alignItems(VerticalAlign.Center).padding({ left: 16, right: 16 }))

              // Copy
              Button()
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .width('100%')
                .height(48)
                .child(Row() {
                  Text('Copy').fontColor('#191D19').layoutWeight(1)
                  Image($r('app.media.startIcon')).width(20).height(20)
                }.alignItems(VerticalAlign.Center).padding({ left: 16, right: 16 }))

              // Share
              Button()
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .width('100%')
                .height(48)
                .child(Row() {
                  Text('Share').fontColor('#191D19').layoutWeight(1)
                  Image($r('app.media.startIcon')).width(20).height(20)
                }.alignItems(VerticalAlign.Center).padding({ left: 16, right: 16 }))

              // Restore
              Button()
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .width('100%')
                .height(48)
                .child(Row() {
                  Text('Restore').fontColor('#191D19').layoutWeight(1)
                  Image($r('app.media.startIcon')).width(20).height(20)
                }.alignItems(VerticalAlign.Center).padding({ left: 16, right: 16 }))

              Divider().color('#E0E0E0').width('100%')

              // Delete
              Button()
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .width('100%')
                .height(48)
                .child(Row() {
                  Text('Delete').fontColor('#BA1A1A').layoutWeight(1)
                  Image($r('app.media.startIcon')).width(20).height(20)
                }.alignItems(VerticalAlign.Center).padding({ left: 16, right: 16 }))
                .onClick(() => {
                  this.showDeleteDialog = true
                })
            }
            .width(250)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .shadow({ radius: 4, color: '#1F000000' })
            .position({ x: -200, y: 48 })
          }
        }
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F8FBF1')

      // === Delete Dialog ===
      if (this.showDeleteDialog) {
        Column() {
          Column() {
            Text('Delete note?')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#191D19')
              .margin({ bottom: 8 })
            
            Text('This note will be moved to trash.')
              .fontSize(14)
              .fontColor('#424940')
              .margin({ bottom: 24 })

            Row({ space: 8 }) {
              Button('Cancel')
                .type(ButtonType.Capsule)
                .backgroundColor(Color.Transparent)
                .fontColor('#191D19')
                .onClick(() => {
                  this.showDeleteDialog = false
                })

              Button('Delete')
                .type(ButtonType.Capsule)
                .backgroundColor('#BA1A1A')
                .fontColor(Color.White)
                .onClick(() => {
                  this.showDeleteDialog = false
                })
            }
          }
          .width('85%')
          .padding(24)
          .backgroundColor('#F8FBF1')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#3F000000' })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#80000000')
      }

      // === Link Dialog ===
      if (this.showLinkDialog) {
        Column() {
          Column() {
            Text('Open link?')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#191D19')
              .margin({ bottom: 8 })
            
            Text(this.linkUrl)
              .fontSize(14)
              .fontColor('#424940')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ bottom: 24 })

            Row({ space: 8 }) {
              Button('Cancel')
                .type(ButtonType.Capsule)
                .backgroundColor(Color.Transparent)
                .fontColor('#191D19')
                .onClick(() => {
                  this.showLinkDialog = false
                })

              Button('Open')
                .type(ButtonType.Capsule)
                .backgroundColor('#6750A4')
                .fontColor(Color.White)
                .onClick(() => {
                  this.showLinkDialog = false
                })
            }
          }
          .width('85%')
          .padding(24)
          .backgroundColor('#F8FBF1')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#3F000000' })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#80000000')
      }
    }
    .width('100%')
    .height('100%')
  }
}