import { LengthMetrics } from '@kit.ArkUI'

// ============================================================
// Design Tokens
// ============================================================
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF00E5FF'
    export const secondary: ResourceColor = '#FFFF00AA'
    export const tertiary: ResourceColor = '#FF76FF03'
    export const background: ResourceColor = '#FF101024'
    export const surface: ResourceColor = '#FF1C1C3A'
    export const surfaceVariant: ResourceColor = '#FF282850'
    export const outline: ResourceColor = '#FF44446A'
    export const success: ResourceColor = '#FF00C853'
    export const warning: ResourceColor = '#FFFFD600'
    export const error: ResourceColor = '#FFFF1744'
    export const onPrimary: ResourceColor = '#FF000000'
    export const onSecondary: ResourceColor = '#FF000000'
    export const onTertiary: ResourceColor = '#FF000000'
    export const onBackground: ResourceColor = '#FFE0E0FF'
    export const onSurface: ResourceColor = '#FFE0E0FF'
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }
}

// ============================================================
// Data Models
// ============================================================
interface Author {
  name: string
  avatarColor: ResourceColor
}

interface Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number
}

interface Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

// ============================================================
// AuthorInfo Component
// ============================================================
@Component
struct AuthorInfo {
  author: Author = { name: '', avatarColor: '#FF000000' }
  timestamp: string = ''

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack() {
        Circle({ width: 24, height: 24 })
          .fill(this.author.avatarColor)
        Circle({ width: 16, height: 16 })
          .fill('#33000000')
      }
      .width(24)
      .height(24)
      .clip(true)
      .borderRadius(12)

      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)
        .letterSpacing(0.5)

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.outline)
        .letterSpacing(0.5)
    }
    .alignItems(VerticalAlign.Center)
  }
}

// ============================================================
// InfoChip Component
// ============================================================
@Component
struct InfoChip {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
      .letterSpacing(0.5)
  }
}

// ============================================================
// UpVoteArrow Component
// ============================================================
@Component
struct UpVoteArrow {
  color: ResourceColor = '#FF000000'
  flipped: boolean = false

  build() {
    Canvas(new RenderingContextSettings(true))
      .width(24)
      .height(24)
      .onReady((context: CanvasRenderingContext2D) => {
        const w = 24
        const h = 24
        context.fillStyle = this.color as string
        context.beginPath()
        if (!this.flipped) {
          context.moveTo(w / 2, 0)
          context.lineTo(w, h / 2)
          context.lineTo(w / 2, h)
          context.lineTo(0, h / 2)
        } else {
          context.moveTo(w / 2, h)
          context.lineTo(w, h / 2)
          context.lineTo(w / 2, 0)
          context.lineTo(0, h / 2)
        }
        context.closePath()
        context.fill()
      })
  }
}

// ============================================================
// PostCard Component
// ============================================================
@Component
struct PostCard {
  post: Post = {
    author: { name: '', avatarColor: '#FF000000' },
    timestamp: '',
    title: '',
    body: '',
    votes: 0,
    commentCount: 0
  }
  @Link voteState: number

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      // Vote column
      Column({ space: AppTokens.Spacing.sm }) {
        Button({ type: ButtonType.Normal }) {
          UpVoteArrow({
            color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline,
            flipped: false
          })
        }
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
        .borderRadius(20)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Bold)

        Button({ type: ButtonType.Normal }) {
          UpVoteArrow({
            color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline,
            flipped: true
          })
        }
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
        .borderRadius(20)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1
        })
      }
      .alignItems(HorizontalAlign.Center)

      // Content column
      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Text(this.post.body)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#CCE0E0FF')
          .lineHeight(24)
          .width('100%')

        Blank().height(AppTokens.Spacing.sm)

        Row({ space: AppTokens.Spacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .padding(AppTokens.Spacing.lg)
    .alignItems(VerticalAlign.Top)
  }
}

// ============================================================
// ReplyCard Component
// ============================================================
@Component
struct ReplyCard {
  reply: Reply = {
    id: 0,
    author: { name: '', avatarColor: '#FF000000' },
    timestamp: '',
    text: '',
    votes: 0
  }

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      // Left accent bar
      Column()
        .width(2)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(2)

      // Content
      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#E6E0E0FF')
          .lineHeight(24)
          .width('100%')

        Row({ space: AppTokens.Spacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

// ============================================================
// Root Screen
// ============================================================
@Entry
@Component
struct RootScreen {
  private post: Post = {
    author: { name: 'user/compose_master', avatarColor: AppTokens.Colors.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }

  private replies: Reply[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: AppTokens.Colors.secondary },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: AppTokens.Colors.primary },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    },
    {
      id: 3,
      author: { name: 'newbie/coder', avatarColor: AppTokens.Colors.warning },
      timestamp: '2h ago',
      text: 'I found it a bit overwhelming at first. Any tips for organizing the file?',
      votes: 3
    }
  ]

  @State voteState: number = 1

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Normal }) {
          Canvas(new RenderingContextSettings(true))
            .width(20)
            .height(20)
            .onReady((ctx: CanvasRenderingContext2D) => {
              ctx.strokeStyle = AppTokens.Colors.primary as string
              ctx.lineWidth = 2
              // horizontal line
              ctx.beginPath()
              ctx.moveTo(0, 10)
              ctx.lineTo(20, 10)
              ctx.stroke()
              // top arrow line
              ctx.beginPath()
              ctx.moveTo(0, 10)
              ctx.lineTo(10, 0)
              ctx.stroke()
              // bottom arrow line
              ctx.beginPath()
              ctx.moveTo(0, 10)
              ctx.lineTo(10, 20)
              ctx.stroke()
            })
        }
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .borderRadius(24)

        Text('r/jetpackcompose')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank().width(48)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

      // Scrollable content
      Scroll() {
        Column() {
          // Post card
          PostCard({ post: this.post, voteState: $voteState })

          // Section header
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.outline)
            .letterSpacing(0.5)
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .width('100%')

          // Reply cards
          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({
                left: AppTokens.Spacing.lg,
                right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm,
                bottom: AppTokens.Spacing.sm
              })
          }, (reply: Reply) => reply.id.toString())

          Blank().height(AppTokens.Spacing.lg)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      // Bottom bar
      Row({ space: AppTokens.Spacing.md }) {
        Row() {
          Text('Add a comment...')
            .fontSize(16)
            .fontColor(AppTokens.Colors.outline)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(16)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .alignItems(VerticalAlign.Center)

        Button('POST', { type: ButtonType.Normal })
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(16)
          .height(48)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}