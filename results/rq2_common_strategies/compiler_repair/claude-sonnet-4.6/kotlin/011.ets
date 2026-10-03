import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#00E5FF'
const COLOR_SECONDARY = '#FF00AA'
const COLOR_TERTIARY = '#76FF03'
const COLOR_BACKGROUND = '#101024'
const COLOR_SURFACE = '#1C1C3A'
const COLOR_SURFACE_VARIANT = '#282850'
const COLOR_OUTLINE = '#44446A'
const COLOR_WARNING = '#FFD600'
const COLOR_ON_PRIMARY = '#000000'
const COLOR_ON_SURFACE = '#E0E0FF'

// Spacing tokens
const SPACING_XS = 4
const SPACING_SM = 8
const SPACING_MD = 12
const SPACING_LG = 16
const SPACING_XL = 24

class AuthorData {
  name: string = ''
  avatarColor: string = ''
}

class ReplyData {
  id: number = 0
  author: AuthorData = new AuthorData()
  timestamp: string = ''
  text: string = ''
  votes: number = 0
}

class PostData {
  author: AuthorData = new AuthorData()
  timestamp: string = ''
  title: string = ''
  body: string = ''
  votes: number = 0
  commentCount: number = 0
}

@Component
struct UpVoteArrow {
  @Prop color: string = COLOR_OUTLINE
  @Prop flipped: boolean = false
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.ctx)
      .width(24)
      .height(24)
      .onReady(() => {
        this.ctx.clearRect(0, 0, 24, 24)
        this.ctx.fillStyle = this.color
        this.ctx.beginPath()
        if (!this.flipped) {
          this.ctx.moveTo(12, 2)
          this.ctx.lineTo(22, 12)
          this.ctx.lineTo(12, 22)
          this.ctx.lineTo(2, 12)
        } else {
          this.ctx.moveTo(12, 22)
          this.ctx.lineTo(22, 12)
          this.ctx.lineTo(12, 2)
          this.ctx.lineTo(2, 12)
        }
        this.ctx.closePath()
        this.ctx.fill()
      })
  }
}

@Component
struct AuthorInfoComp {
  @Prop authorName: string = ''
  @Prop authorColor: string = ''
  @Prop timestamp: string = ''

  build() {
    Row({ space: SPACING_SM }) {
      Stack() {
        Circle()
          .width(24)
          .height(24)
          .fill(this.authorColor)
        Circle()
          .width(10)
          .height(10)
          .fill('rgba(0,0,0,0.2)')
      }
      .width(24)
      .height(24)

      Text(this.authorName)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.authorColor)

      Text(this.timestamp)
        .fontSize(14)
        .fontColor(COLOR_OUTLINE)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  @Prop text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(COLOR_OUTLINE)
  }
}

@Component
struct PostCardComp {
  @Prop post: PostData = new PostData()
  @Prop voteState: number = 1
  onVote: (v: number) => void = () => {}

  build() {
    Row({ space: SPACING_MD }) {
      // Vote column
      Column({ space: SPACING_SM }) {
        Button({ type: ButtonType.Normal }) {
          UpVoteArrow({
            color: this.voteState === 1 ? COLOR_SECONDARY : COLOR_OUTLINE,
            flipped: false
          })
        }
        .backgroundColor('transparent')
        .width(40)
        .height(40)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? COLOR_SECONDARY : COLOR_ON_SURFACE)

        Button({ type: ButtonType.Normal }) {
          UpVoteArrow({
            color: this.voteState === -1 ? COLOR_PRIMARY : COLOR_OUTLINE,
            flipped: true
          })
        }
        .backgroundColor('transparent')
        .width(40)
        .height(40)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .alignItems(HorizontalAlign.Center)

      // Content column
      Column({ space: SPACING_SM }) {
        AuthorInfoComp({
          authorName: this.post.author.name,
          authorColor: this.post.author.avatarColor,
          timestamp: this.post.timestamp
        })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)

        Text(this.post.body)
          .fontSize(16)
          .fontColor(COLOR_ON_SURFACE)
          .opacity(0.8)
          .lineHeight(24)

        Row({ space: SPACING_XL }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: SPACING_SM })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .backgroundColor(COLOR_SURFACE)
    .padding(SPACING_LG)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct ReplyCardComp {
  @Prop reply: ReplyData = new ReplyData()

  build() {
    Row({ space: SPACING_MD }) {
      // Left accent bar
      Column()
        .width(2)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(2)

      // Content
      Column({ space: SPACING_XS }) {
        AuthorInfoComp({
          authorName: this.reply.author.name,
          authorColor: this.reply.author.avatarColor,
          timestamp: this.reply.timestamp
        })

        Text(this.reply.text)
          .fontSize(16)
          .fontColor(COLOR_ON_SURFACE)
          .opacity(0.9)
          .lineHeight(24)

        Row({ space: SPACING_MD }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Entry
@Component
struct Index {
  @State voteState: number = 1

  private post: PostData = {
    author: { name: 'user/compose_master', avatarColor: COLOR_TERTIARY },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }

  private replies: ReplyData[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: COLOR_SECONDARY },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: COLOR_PRIMARY },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    },
    {
      id: 3,
      author: { name: 'newbie/coder', avatarColor: COLOR_WARNING },
      timestamp: '2h ago',
      text: 'I found it a bit overwhelming at first. Any tips for organizing the file?',
      votes: 3
    }
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Normal }) {
          // Back arrow drawn with shapes
          Row() {
            Text('<')
              .fontSize(20)
              .fontColor(COLOR_PRIMARY)
              .fontWeight(FontWeight.Bold)
          }
        }
        .backgroundColor('transparent')
        .width(48)
        .height(48)

        Text('r/jetpackcompose')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .width(48)
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_SURFACE)
      .alignItems(VerticalAlign.Center)
      .padding({ left: SPACING_SM, right: SPACING_SM })

      // Scrollable content
      Scroll() {
        Column() {
          // Post card
          PostCardComp({
            post: this.post,
            voteState: this.voteState,
            onVote: (v: number) => {
              this.voteState = v
            }
          })

          // Section header
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontColor(COLOR_OUTLINE)
            .fontWeight(FontWeight.Medium)
            .padding({
              left: SPACING_LG,
              right: SPACING_LG,
              top: SPACING_SM,
              bottom: SPACING_SM
            })

          // Replies
          ForEach(this.replies, (reply: ReplyData) => {
            ReplyCardComp({ reply: reply })
              .padding({
                left: SPACING_LG,
                right: SPACING_LG,
                top: SPACING_SM,
                bottom: SPACING_SM
              })
          }, (reply: ReplyData) => reply.id.toString())

          // Bottom padding
          Blank().height(80)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom bar
      Row({ space: SPACING_MD }) {
        Row() {
          Text('Add a comment...')
            .fontSize(16)
            .fontColor(COLOR_OUTLINE)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(16)
        .padding({ left: SPACING_LG, right: SPACING_LG })
        .alignItems(VerticalAlign.Center)

        Button('POST', { type: ButtonType.Normal })
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(16)
          .height(48)
          .padding({ left: SPACING_LG, right: SPACING_LG })
      }
      .width('100%')
      .backgroundColor(COLOR_SURFACE)
      .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}