@Entry
@Component
struct Index {
  @State dateText: string = 'Today'
  @State title: string = 'Weekend shopping list'
  @State content: string = ''
  @State checked: boolean = false
  @State showOverflow: boolean = false
  @State showDeleteDialog: boolean = false
  @State showLinkDialogUrl: string | null = null

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        Text(this.dateText)
          .fontColor('#424940')
          .fontSize(14)
          .width('100%')
          .padding({ top: 8, bottom: 8 })

        TextInput({ placeholder: 'Title' })
          .placeholderColor('#424940')
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .height(56)
          .width('100%')
          .onChange((value: string) => {
            this.title = value
          })

        Blank().height(12)

        TextInput({ placeholder: 'Start writing...' })
          .placeholderColor('#424940')
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .layoutWeight(1)
          .width('100%')
          .onChange((value: string) => {
            this.content = value
          })

        List({ space: 8 }) {
          ListItem() {
            Row({ space: 0 }) {
              Checkbox({ name: 'item', group: 'group1' })
                .checked(false)
                .onChange((isChecked: boolean) => {
                  this.checked = isChecked
                })

              TextInput({ placeholder: 'List item' })
                .placeholderColor('#424940')
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .layoutWeight(1)

              Button() {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
              }
              .type(ButtonType.Normal)
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .onClick(() => {
                // Remove item
              })
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }

          ListItem() {
            Button() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                Blank().width(4)
                Text('Add item')
                  .fontColor('#424940')
              }
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .onClick(() => {
              // Add item
            })
          }
        }
        .width('100%')
        .layoutWeight(1)

        Blank().height(8)

        Row({ space: 8 }) {
          ForEach(['label.name'], (it: string) => {
            Button() {
              Text(it)
                .fontColor('#424940')
                .fontSize(12)
            }
            .type(ButtonType.Capsule)
            .backgroundColor('#E8DEF8')
            .onClick(() => {
              // Change labels
            })
          })

          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(16)
                .height(16)
              Text('Reminder')
                .fontColor('#424940')
                .fontSize(12)
            }
          }
          .type(ButtonType.Capsule)
          .backgroundColor('#F3E8FF')
          .onClick(() => {
            // Change reminder
          })
        }
        .width('100%')

        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })

      TopAppBar() {
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .onClick(() => {
            // Back
          })

          Text('Edit Note')
            .fontColor('#191D19')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 16 })

          Blank().layoutWeight(1)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .onClick(() => {
            // Toggle pin
          })

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .onClick(() => {
            // Change reminder
          })

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .onClick(() => {
            // Change labels
          })

          Stack({ alignContent: Alignment.Center }) {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .onClick(() => {
              this.showOverflow = true
            })

            if (this.showOverflow) {
              DropdownMenu({ items: ['Convert to List', 'Copy', 'Share', 'Restore', 'Delete'] }) {
                DropdownMenuItem({ text: 'Convert to List' })
                  .onClick(() => {
                    this.showOverflow = false
                  })
                DropdownMenuItem({ text: 'Copy' })
                  .onClick(() => {
                    this.showOverflow = false
                  })
                DropdownMenuItem({ text: 'Share' })
                  .onClick(() => {
                    this.showOverflow = false
                  })
                DropdownMenuItem({ text: 'Restore' })
                  .onClick(() => {
                    this.showOverflow = false
                  })
                Divider()
                DropdownMenuItem({ text: 'Delete' })
                  .fontColor('#BA1A1A')
                  .onClick(() => {
                    this.showOverflow = false
                    this.showDeleteDialog = true
                  })
              }
            }
          }
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FBF1')

    if (this.showDeleteDialog) {
      AlertDialog({
        title: 'Delete note?',
        message: 'This note will be moved to trash.',
        buttons: [
          {
            text: 'Delete',
            fontColor: '#BA1A1A',
            onClick: () => {
              this.showDeleteDialog = false
            }
          },
          {
            text: 'Cancel',
            fontColor: '#424940',
            onClick: () => {
              this.showDeleteDialog = false
            }
          }
        ]
      })
    }

    if (this.showLinkDialogUrl !== null) {
      AlertDialog({
        title: 'Open link?',
        message: this.showLinkDialogUrl,
        buttons: [
          {
            text: 'Open',
            fontColor: '#424940',
            onClick: () => {
              this.showLinkDialogUrl = null
            }
          },
          {
            text: 'Cancel',
            fontColor: '#424940',
            onClick: () => {
              this.showLinkDialogUrl = null
            }
          }
        ]
      })
    }
  }
}