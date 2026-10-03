import { GridItemController } from '@kit.ArkUI'

@Entry
@Component
struct HomeScreen {
  @State notes: Note[] = []

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Column() {
            Text('Hi there!')
              .fontWeight(FontWeight.Bold)
              .fontSize(18)
              .fontColor('#000000')
            Text('Welcome back')
              .fontSize(12)
              .fontColor('#666666')
          }
          .layoutWeight(1)

          Button('', { type: ButtonType.Circle })
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              // Settings click handler
            })
            .borderRadius(20)
            .icon($r('app.media.ic_settings'))
            .iconColor('#000000')
        }
        .width('100%')
        .padding({ left: 16, top: 16, right: 8 })
        .alignItems(VerticalAlign.Center)

        Spacer().height(16)

        if (this.notes.length === 0) {
          // Empty state
          Column() {
            Image($r('app.media.ic_undraw_empty'))
              .width(120)
              .height(120)
              .objectFit(ImageFit.Contain)
            
            Text('Your record list is empty.\nClick the button below to get started.')
              .fontSize(12)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
              .margin({ top: 8 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else {
          // Notes grid
          GridContainer(this.getGridOptions())
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('auto')
            .gaps({ row: 8, column: 8 })
            .width('100%')
            .padding(8)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFECF1')

      // FAB
      Button('', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .backgroundColor('#EFB8C8')
        .borderRadius(16)
        .position({ right: 16, bottom: 16 })
        .onClick(() => {
          // Add note click handler
        })
        .icon($r('app.media.ic_mic_black_24dp'))
        .iconColor('#000000')
    }
    .width('100%')
    .height('100%')
  }

  private getGridOptions(): GridContainerOptions {
    return {
      items: this.notes.map((note) => {
        return {
          id: note.id.toString(),
          component: new NoteCard(note)
        }
      })
    }
  }
}

@Component
struct NoteCard {
  @Prop note: Note

  build() {
    Column() {
      Row() {
        Text(this.note.title)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)
        
        Text(formatDateStamp(this.note.lastModificationDate))
          .fontSize(10)
          .fontColor(Color.White)
          .maxLines(1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Spacer().height(8)

      Row() {
        Image($r('app.media.mic'))
          .width(14)
          .height(14)
          .fillColor(Color.White)
        
        Text(formatAudioLength(this.note.audioLength))
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 4 })
        
        Text(this.note.size)
          .fontSize(12)
          .fontColor(Color.White)
          .margin({ left: 'auto' })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Spacer().height(8)

      Row() {
        Image($r('app.media.alarm'))
          .width(14)
          .height(14)
          .fillColor(Color.White)
          .opacity(0.6)
        
        Text(this.note.reminder ? formatReminderText(this.note.reminder) : 'No reminder set')
          .fontSize(12)
          .fontColor(Color.White)
          .opacity(0.6)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .decoration(this.note.reminder && Date.now() > this.note.reminder ? TextDecoration.LineThrough : TextDecoration.None)
          .margin({ left: 4 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#' + this.note.color.toString(16).padStart(6, '0'))
    .borderRadius(8)
    .shadow({ radius: 4, color: '#00000033', offsetY: 2 })
    .onClick(() => {
      // Note click handler
    })
  }
}

interface Note {
  id: number
  title: string
  audioLength: number
  size: string
  reminder?: number
  lastModificationDate: number
  color: number
}

function formatDateStamp(millis: number): string {
  if (millis <= 0) return ''
  const date = new Date(millis)
  return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear() % 100}`
}

function formatAudioLength(seconds: number): string {
  if (seconds <= 0) return '00:00'
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
}

function formatReminderText(millis: number): string {
  const date = new Date(millis)
  return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear() % 100} ${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`
}