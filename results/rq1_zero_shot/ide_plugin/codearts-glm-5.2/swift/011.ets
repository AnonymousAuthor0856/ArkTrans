class AppTokens {
  static readonly Colors = {
    primary: '#FF00E5FF',
    secondary: '#FFFF00AA',
    tertiary: '#FF76FF03',
    background: '#FF101024',
    surface: '#FF1C1C3A',
    surfaceVariant: '#FF282850',
    outline: '#FF44446A',
    warning: '#FFFFD600',
    onPrimary: '#FF000000',
    onSurface: '#FFE0E0FF',
    onSurface80: '#CCE0E0FF',
    onSurface90: '#E6E0E0FF',
    outline30: '#4D44446A',
    black20: '#33000000',
    secondary50: '#80FF00AA',
    primary50: '#8000E5FF'
  }

  static readonly Spacing = {
    xs: 6,
    sm: 10,
    md: 16,
    lg: 20,
    xl: 28
  }
}

class Reply {
  id: number
  authorName: string
  authorColor: string
  authorColor50: string
  timestamp: string
  text: string
  votes: number

  constructor(id: number, authorName: string, authorColor: string, authorColor50: string,
    timestamp: string, text: string, votes: number) {
    this.id = id
    this.authorName = authorName
    this.authorColor = authorColor
    this.authorColor50 = authorColor50
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1
  @State commentText: string = ''

  private postAuthorName: string = 'user/compose_master'
  private postAuthorColor: string = AppTokens.Colors.tertiary
  private postTimestamp: string = '8 hours ago'
  private postTitle: string = 'The power of Jetpack Compose for single-file UIs'
  private postBody: string = 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?'
  private postVotes: number = 1337
  private postCommentCount: number = 42

  private replies: Reply[] = [
    new Reply(1, 'dev/android_fan', AppTokens.Colors.secondary, AppTokens.Colors.secondary50,
      '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, 'ux/designer_jane', AppTokens.Colors.primary, AppTokens.Colors.primary50,
      '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18)
  ]

  build() {
    Column() {
      Row() {
        Text('←')
          .fontSize(24)
          .fontColor(AppTokens.Colors.primary)
          .width(50)
          .height(50)
          .textAlign(TextAlign.Center)

        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row()
          .width(50)
          .height(50)
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: 20, right: 20 })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Row() {
            Column() {
              Text('▲')
                .fontSize(28)
                .fontColor(this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
                .onClick(() => {
                  this.voteState = this.voteState === 1 ? 0 : 1
                })
              Text(`${this.postVotes + this.voteState - 1}`)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
              Text('▼')
                .fontSize(28)
                .fontColor(this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline)
                .onClick(() => {
                  this.voteState = this.voteState === -1 ? 0 : -1
                })
            }
            .width(60)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)

            Column() {
              Row() {
                Stack() {
                  Row()
                    .width(28)
                    .height(28)
                    .borderRadius(14)
                    .backgroundColor(this.postAuthorColor)
                  Row()
                    .width(10)
                    .height(10)
                    .borderRadius(5)
                    .backgroundColor(AppTokens.Colors.black20)
                }
                .width(28)
                .height(28)
                Text(this.postAuthorName)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.postAuthorColor)
                  .margin({ left: 10 })
                Text(this.postTimestamp)
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.outline)
                  .margin({ left: 10 })
              }
              .alignItems(VerticalAlign.Center)

              Text(this.postTitle)
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: 10 })

              Text(this.postBody)
                .fontSize(18)
                .fontColor(AppTokens.Colors.onSurface80)
                .margin({ top: 10 })

              Row() {
                Text(`${this.postCommentCount} Comments`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.outline)
                Text('Share')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.outline)
                  .margin({ left: 28 })
              }
              .margin({ top: 10 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: 16 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor(AppTokens.Colors.surface)
          .alignItems(VerticalAlign.Top)

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.outline)
            .width('100%')
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })

          ForEach(this.replies, (reply: Reply) => {
            Row() {
              Column()
                .width(3)
                .borderRadius(1.5)
                .backgroundColor(reply.authorColor50)

              Column() {
                Row() {
                  Stack() {
                    Row()
                      .width(28)
                      .height(28)
                      .borderRadius(14)
                      .backgroundColor(reply.authorColor)
                    Row()
                      .width(10)
                      .height(10)
                      .borderRadius(5)
                      .backgroundColor(AppTokens.Colors.black20)
                  }
                  .width(28)
                  .height(28)
                  Text(reply.authorName)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(reply.authorColor)
                    .margin({ left: 10 })
                  Text(reply.timestamp)
                    .fontSize(14)
                    .fontColor(AppTokens.Colors.outline)
                    .margin({ left: 10 })
                }
                .alignItems(VerticalAlign.Center)

                Text(reply.text)
                  .fontSize(18)
                  .fontColor(AppTokens.Colors.onSurface90)
                  .margin({ top: 6 })

                Row() {
                  Text(`${reply.votes} votes`)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.outline)
                  Text('Reply')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.outline)
                    .margin({ left: 16 })
                }
                .margin({ top: 6 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 16 })
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
            .alignItems(VerticalAlign.Top)
          })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Divider()
          .color(AppTokens.Colors.outline30)
          .strokeWidth(1)

        Row() {
          TextInput({ text: this.commentText, placeholder: 'Add a comment...' })
            .layoutWeight(1)
            .height(52)
            .borderRadius(20)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .fontSize(18)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.outline)
            .padding({ left: 20, right: 20 })
            .onChange((value: string) => {
              this.commentText = value
            })

          Text('POST')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onPrimary)
            .height(52)
            .borderRadius(20)
            .backgroundColor(AppTokens.Colors.primary)
            .padding({ left: 20, right: 20 })
            .textAlign(TextAlign.Center)
            .margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor(AppTokens.Colors.surface)
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}