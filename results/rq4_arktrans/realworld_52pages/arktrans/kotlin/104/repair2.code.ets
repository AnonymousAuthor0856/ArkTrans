@Entry
@Component
struct Index {
  @State dateText: string = 'Today'
  @State title: string = ''
  @State content: string = ''
  @State checked: boolean = false
  @State showOverflow: boolean = false
  @State showDeleteDialog: boolean = false
  @State showLinkDialogUrl: string | null = null

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content ===
      Column({ space: 0 }) {
        // === Date Text ===
        Text(this.dateText)
          .fontColor('#424940')
          .fontSize(14)
          .width('100%')
          .padding({ top: 8, bottom: 8 })

        // === Title Input ===
        TextInput({ placeholder: 'Title' })
          .type(InputType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .placeholderColor('#424940')
          .fontColor('#424940')
          .fontSize(22)
          .width('100%')
          .onChange((value: string) => {
            this.title = value
          })

        Blank().height(12)

        // === Content Input ===
        TextInput({ placeholder: 'Start writing...' })
          .type(InputType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .placeholderColor('#424940')
          .fontColor('#424940')
          .fontSize(16)
          .width('100%')
          .layoutWeight(1)
          .onChange((value: string) => {
            this.content = value
          })

        // === List Section ===
        List({ space: 8 }) {
          ListItem() {
            Row({ space: 0 }) {
              Checkbox({ name: 'itemCheck', group: 'group1' })
                .checked(this.checked)
                .selectedColor('#424940')
                .onChange((isSelect: boolean) => {
                  this.checked = isSelect
                })

              TextInput({ placeholder: 'List item' })
                .type(InputType.Normal)
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .placeholderColor('#424940')
                .fontColor('#424940')
                .fontSize(16)
                .layoutWeight(1)

              Button() {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                  .fillColor('#424940')
              }
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .margin({ left: 8 })
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }

          ListItem() {
            Button() {
              Row({ space: 4 }) {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                  .fillColor('#424940')
                Text('Add item')
                  .fontColor('#424940')
              }
            }
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
          }
        }
        .width('100%')

        Blank().height(8)

        // === Chips Row ===
        Row({ space: 8 }) {
          // Label Chip
          Button() {
            Text('label.name')
              .fontColor('#191D19')
              .fontSize(12)
          }
          .backgroundColor('#E8DEF8')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })

          // Reminder Chip
          Button() {
            Row({ space: 4 }) {
              Image($r('app.media.startIcon'))
                .width(16)
                .height(16)
                .fillColor('#191D19')
              Text('Reminder')
                .fontColor('#191D19')
                .fontSize(12)
            }
          }
          .backgroundColor('#F3E8FF')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        }
        .width('100%')

        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F8FBF1')

      // === TopAppBar ===
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#191D19')
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)

        Text('Edit Note')
          .fontColor('#191D19')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#424940')
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#424940')
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#424940')
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)

        Stack({ alignContent: Alignment.Center }) {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#191D19')
          }
          .backgroundColor(Color.Transparent)
          .borderWidth(0)

          if (this.showOverflow) {
            Column() {
              Button() {
                Row({ space: 8 }) {
                  Text('Convert to List').fontColor('#191D19')
                  Image($r('app.media.startIcon')).width(16).height(16).fillColor('#191D19')
                }
              }
              .backgroundColor(Color.White)
              .borderWidth(0)
              .width('100%')
              .padding(16)

              Button() {
                Row({ space: 8 }) {
                  Text('Copy').fontColor('#191D19')
                  Image($r('app.media.startIcon')).width(16).height(16).fillColor('#191D19')
                }
              }
              .backgroundColor(Color.White)
              .borderWidth(0)
              .width('100%')
              .padding(16)

              Button() {
                Row({ space: 8 }) {
                  Text('Share').fontColor('#191D19')
                  Image($r('app.media.startIcon')).width(16).height(16).fillColor('#191D19')
                }
              }
              .backgroundColor(Color.White)
              .borderWidth(0)
              .width('100%')
              .padding(16)

              Button() {
                Row({ space: 8 }) {
                  Text('Restore').fontColor('#191D19')
                  Image($r('app.media.startIcon')).width(16).height(16).fillColor('#191D19')
                }
              }
              .backgroundColor(Color.White)
              .borderWidth(0)
              .width('100%')
              .padding(16)

              Divider().color('#E0E0E0')

              Button() {
                Row({ space: 8 }) {
                  Text('Delete').fontColor('#BA1A1A')
                  Image($r('app.media.startIcon')).width(16).height(16).fillColor('#BA1A1A')
                }
              }
              .backgroundColor(Color.White)
              .borderWidth(0)
              .width('100%')
              .padding(16)
            }
            .width(200)
            .position({ x: -150, y: 40 })
            .shadow({ radius: 4, color: '#1F000000' })
            .onClick(() => {
              this.showOverflow = false
            })
          }
        }
        .onClick(() => {
          this.showOverflow = !this.showOverflow
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F8FBF1')
      .alignItems(VerticalAlign.Center)

      // === Delete Dialog ===
      if (this.showDeleteDialog) {
        Column() {
          Column() {
            Text('Delete note?')
              .fontColor('#191D19')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .textAlign(TextAlign.Start)
            
            Text('This note will be moved to trash.')
              .fontColor('#424940')
              .fontSize(14)
              .width('100%')
              .margin({ top: 8 })
              .textAlign(TextAlign.Start)

            Row({ space: 8 }) {
              Button() {
                Text('Cancel').fontColor('#424940')
              }
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              
              Button() {
                Text('Delete').fontColor('#BA1A1A')
              }
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
            }
            .justifyContent(FlexAlign.End)
            .width('100%')
            .margin({ top: 24 })
          }
          .width(300)
          .padding(24)
          .backgroundColor('#F8FBF1')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1F000000' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }

      // === Link Dialog ===
      if (this.showLinkDialogUrl) {
        Column() {
          Column() {
            Text('Open link?')
              .fontColor('#191D19')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .textAlign(TextAlign.Start)
            
            Text(this.showLinkDialogUrl)
              .fontColor('#424940')
              .fontSize(14)
              .width('100%')
              .margin({ top: 8 })
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .textAlign(TextAlign.Start)

            Row({ space: 8 }) {
              Button() {
                Text('Cancel').fontColor('#424940')
              }
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              
              Button() {
                Text('Open').fontColor('#424940')
              }
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
            }
            .justifyContent(FlexAlign.End)
            .width('100%')
            .margin({ top: 24 })
          }
          .width(300)
          .padding(24)
          .backgroundColor('#F8FBF1')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1F000000' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}