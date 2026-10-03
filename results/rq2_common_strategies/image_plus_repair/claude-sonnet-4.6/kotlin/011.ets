import { curves } from '@kit.ArkUI'

// ── Design Tokens ──────────────────────────────────────────────────────────────

const COLOR_PRIMARY = '#FF00E5FF'
const COLOR_SECONDARY = '#FFFF00AA'
const COLOR_TERTIARY = '#FF76FF03'
const COLOR_BACKGROUND = '#FF101024'
const COLOR_SURFACE = '#FF1C1C3A'
const COLOR_SURFACE_VARIANT = '#FF282850'
const COLOR_OUTLINE = '#FF44446A'
const COLOR_WARNING = '#FFFFD600'
const COLOR_ON_PRIMARY = '#FF000000'
const COLOR_ON_SURFACE = '#FFE0E0FF'
const COLOR_ON_SURFACE_DIM = '#CCE0E0FF'

// ── Data Models ────────────────────────────────────────────────────────────────

interface AuthorModel {
  name: string
  avatarColor: string
}

interface ReplyModel {
  id: number
  author: AuthorModel
  timestamp: string
  text: string
  votes: number
}

interface PostModel {
  author: AuthorModel
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

// ── Diamond / Arrow shape drawn with Path2D ────────────────────────────────────

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
        const w = 24
        const h = 24
        this.ctx.clearRect(0, 0, w, h)
        this.ctx.fillStyle = this.color
        this.ctx.beginPath()
        if (!this.flipped) {
          this.ctx.moveTo(w / 2, 2)
          this.ctx.lineTo(w - 2, h / 2)
          this.ctx.lineTo(w / 2, h - 2)
          this.ctx.lineTo(2, h / 2)
        } else {
          this.ctx.moveTo(w / 2, h - 2)
          this.ctx.lineTo(w - 2, h / 2)
          this.ctx.lineTo(w / 2, 2)
          this.ctx.lineTo(2, h / 2)
        }
        this.ctx.closePath()
        this.ctx.fill()
      })
  }
}

// ── Avatar circle ──────────────────────────────────────────────────────────────

@Component
struct AvatarCircle {
  @Prop avatarColor: string = COLOR_PRIMARY
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.ctx)
      .width(24)
      .height(24)
      .borderRadius(12)
      .onReady(() => {
        const r = 12
        this.ctx.clearRect(0, 0, 24, 24)
        this.ctx.fillStyle = this.avatarColor
        this.ctx.beginPath()
        this.ctx.arc(r, r, r, 0, Math.PI * 2)
        this.ctx.fill()
        this.ctx.fillStyle = 'rgba(0,0,0,0.2)'
        this.ctx.beginPath()
        this.ctx.arc(r, r, r / 3, 0, Math.PI * 2)
        this.ctx.fill()
      })
  }
}

// ── Author info row ────────────────────────────────────────────────────────────

@Component
struct AuthorInfo {
  @Prop authorName: string = ''
  @Prop authorColor: string = COLOR_PRIMARY
  @Prop timestamp: string = ''

  build() {
    Row({ space: 8 }) {
      AvatarCircle({ avatarColor: this.authorColor })
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

// ── Info chip ──────────────────────────────────────────────────────────────────

@Component
struct InfoChip {
  @Prop label: string = ''

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(COLOR_OUTLINE)
  }
}

// ── Post card ──────────────────────────────────────────────────────────────────

@Component
struct PostCard {
  @Prop post: PostModel = {
    author: { name: '', avatarColor: COLOR_TERTIARY },
    timestamp: '',
    title: '',
    body: '',
    votes: 0,
    commentCount: 0
  }
  @Prop voteState: number = 1
  onVote: (v: number) => void = () => {}

  build() {
    Row({ space: 12 }) {
      // Vote column
      Column({ space: 8 }) {
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
      Column({ space: 8 }) {
        AuthorInfo({
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
          .fontColor(COLOR_ON_SURFACE_DIM)
          .lineHeight(24)
        Row({ space: 24 }) {
          InfoChip({ label: `${this.post.commentCount} Comments` })
          InfoChip({ label: 'Share' })
        }
        .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .backgroundColor(COLOR_SURFACE)
    .padding(16)
  }
}

// ── Reply card ─────────────────────────────────────────────────────────────────

@Component
struct ReplyCard {
  @Prop reply: ReplyModel = {
    id: 0,
    author: { name: '', avatarColor: COLOR_PRIMARY },
    timestamp: '',
    text: '',
    votes: 0
  }

  build() {
    Row({ space: 12 }) {
      // Colored left border bar
      Column()
        .width(2)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor)
        .borderRadius(2)
        .opacity(0.5)

      Column({ space: 4 }) {
        AuthorInfo({
          authorName: this.reply.author.name,
          authorColor: this.reply.author.avatarColor,
          timestamp: this.reply.timestamp
        })
        Text(this.reply.text)
          .fontSize(16)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(24)
          .opacity(0.9)
        Row({ space: 12 }) {
          InfoChip({ label: `${this.reply.votes} votes` })
          InfoChip({ label: 'Reply' })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ left: 16, right: 16, top: 8, bottom: 8 })
  }
}

// ── Back arrow drawn on canvas ─────────────────────────────────────────────────

@Component
struct BackArrow {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.ctx)
      .width(20)
      .height(20)
      .onReady(() => {
        const w = 20
        const h = 20
        this.ctx.clearRect(0, 0, w, h)
        this.ctx.strokeStyle = COLOR_PRIMARY
        this.ctx.lineWidth = 2
        this.ctx.lineCap = 'round'
        // horizontal line
        this.ctx.beginPath()
        this.ctx.moveTo(0, h / 2)
        this.ctx.lineTo(w, h / 2)
        this.ctx.stroke()
        // upper arm
        this.ctx.beginPath()
        this.ctx.moveTo(0, h / 2)
        this.ctx.lineTo(w / 2, 0)
        this.ctx.stroke()
        // lower arm
        this.ctx.beginPath()
        this.ctx.moveTo(0, h / 2)
        this.ctx.lineTo(w / 2, h)
        this.ctx.stroke()
      })
  }
}

// ── Root screen ────────────────────────────────────────────────────────────────

@Entry
@Component
struct RootScreen {
  @State voteState: number = 1

  private post: PostModel = {
    author: { name: 'user/compose_master', avatarColor: COLOR_TERTIARY },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }

  private replies: ReplyModel[] = [
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
      // ── Top App Bar ──────────────────────────────────────────────────────────
      Row() {
        Button({ type: ButtonType.Normal }) {
          BackArrow()
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

        // Spacer to balance the back button
        Column().width(48)
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_SURFACE)
      .alignItems(VerticalAlign.Center)

      // ── Scrollable content ───────────────────────────────────────────────────
      Scroll() {
        Column() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (v: number) => {
              this.voteState = v
            }
          })

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontColor(COLOR_OUTLINE)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 4 })

          ForEach(this.replies, (reply: ReplyModel) => {
            ReplyCard({ reply: reply })
          }, (reply: ReplyModel) => reply.id.toString())

          // Bottom padding so content isn't hidden behind bottom bar
          Column().height(80)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      // ── Bottom Bar ───────────────────────────────────────────────────────────
      Row({ space: 12 }) {
        Row() {
          Text('Add a comment...')
            .fontSize(16)
            .fontColor(COLOR_OUTLINE)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(16)
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)

        Button('POST')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(16)
          .height(48)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(COLOR_SURFACE)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}