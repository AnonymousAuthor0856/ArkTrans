package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.graphics.vector.rememberVectorPainter
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "008_ForumPost_en"
private const val UI_TYPE = "Social Forum Post"
private const val STYLE_THEME = "Dark Neon"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF00E5FF)
        val secondary = Color(0xFFFF00AA)
        val tertiary = Color(0xFF76FF03)
        val background = Color(0xFF101024)
        val surface = Color(0xFF1C1C3A)
        val surfaceVariant = Color(0xFF282850)
        val outline = Color(0xFF44446A)
        val success = Color(0xFF00C853)
        val warning = Color(0xFFFFD600)
        val error = Color(0xFFFF1744)
        val onPrimary = Color(0xFF000000)
        val onSecondary = Color(0xFF000000)
        val onTertiary = Color(0xFF000000)
        val onBackground = Color(0xFFE0E0FF)
        val onSurface = Color(0xFFE0E0FF)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Normal, lineHeight = 24.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.5.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 1.dp, 0.1f)
        val level2 = ShadowSpec(3.dp, 4.dp, 2.dp, 0.12f)
        val level3 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.14f)
    }
}

private val AppColorScheme = darkColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displaySmall = AppTokens.TypographyTokens.display,
    headlineSmall = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyLarge = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class Author(val name: String, val avatarColor: Color)
data class Reply(val id: Int, val author: Author, val timestamp: String, val text: String, val votes: Int)
data class Post(val author: Author, val timestamp: String, val title: String, val body: String, val votes: Int, val commentCount: Int)

@Composable
fun UpVoteArrow(modifier: Modifier = Modifier, color: Color) {
    Canvas(modifier = modifier.size(24.dp)) {
        val path = Path().apply {
            moveTo(size.width / 2, 0f)
            lineTo(size.width, size.height / 2)
            lineTo(size.width / 2, size.height)
            lineTo(0f, size.height / 2)
            close()
        }
        drawPath(path, color)
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val post = Post(
        author = Author("user/compose_master", AppTokens.Colors.tertiary),
        timestamp = "8 hours ago",
        title = "The power of Jetpack Compose for single-file UIs",
        body = "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
        votes = 1337,
        commentCount = 42
    )
    val replies = remember {
        listOf(
            Reply(1, Author("dev/android_fan", AppTokens.Colors.secondary), "7h ago", "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.", 25),
            Reply(2, Author("ux/designer_jane", AppTokens.Colors.primary), "5h ago", "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.", 18),
            Reply(3, Author("newbie/coder", AppTokens.Colors.warning), "2h ago", "I found it a bit overwhelming at first. Any tips for organizing the file?", 3)
        )
    }
    var voteState by remember { mutableStateOf(1) }

    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("r/jetpackcompose", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface) },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Canvas(modifier = Modifier.size(20.dp)) {
                            drawLine(color = AppTokens.Colors.primary, start = Offset(0f, center.y), end = Offset(size.width, center.y), strokeWidth = 2.dp.toPx())
                            drawLine(color = AppTokens.Colors.primary, start = Offset(0f, center.y), end = Offset(size.width/2, 0f), strokeWidth = 2.dp.toPx())
                            drawLine(color = AppTokens.Colors.primary, start = Offset(0f, center.y), end = Offset(size.width/2, size.height), strokeWidth = 2.dp.toPx())
                        }
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.surface)
            )
        },
        bottomBar = {
            Surface(color = AppTokens.Colors.surface, tonalElevation = AppTokens.ElevationMapping.level3.elevation) {
                Row(
                    modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg, AppTokens.Spacing.md),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    Box(modifier = Modifier.weight(1f).height(48.dp).clip(AppTokens.Shapes.large).background(AppTokens.Colors.surfaceVariant).padding(horizontal = AppTokens.Spacing.lg), contentAlignment = Alignment.CenterStart) {
                        Text("Add a comment...", color = AppTokens.Colors.outline, style = MaterialTheme.typography.bodyLarge)
                    }
                    Button(onClick = {}, shape = AppTokens.Shapes.large, colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary), contentPadding = PaddingValues(AppTokens.Spacing.lg)) {
                        Text("POST", style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.onPrimary, fontWeight = FontWeight.Bold)
                    }
                }
            }
        }
    ) { paddingValues ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(paddingValues),
            contentPadding = PaddingValues(vertical = AppTokens.Spacing.lg)
        ) {
            item { PostCard(post = post, voteState = voteState, onVote = { voteState = it }) }
            item {
                Text(
                    "TOP COMMENTS",
                    style = MaterialTheme.typography.labelMedium,
                    color = AppTokens.Colors.outline,
                    modifier = Modifier.padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.sm)
                )
            }
            items(replies) { reply ->
                ReplyCard(reply = reply, modifier = Modifier.padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.sm))
            }
        }
    }
}

@Composable
fun PostCard(post: Post, voteState: Int, onVote: (Int) -> Unit) {
    Row(
        modifier = Modifier.fillMaxWidth().background(AppTokens.Colors.surface).padding(AppTokens.Spacing.lg),
        horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
            IconButton(onClick = { onVote(if (voteState == 1) 0 else 1) }) {
                UpVoteArrow(color = if (voteState == 1) AppTokens.Colors.secondary else AppTokens.Colors.outline)
            }
            Text((post.votes + voteState - 1).toString(), style = MaterialTheme.typography.titleMedium, color = if (voteState != 0) AppTokens.Colors.secondary else AppTokens.Colors.onSurface, fontWeight = FontWeight.Bold)
            IconButton(onClick = { onVote(if (voteState == -1) 0 else -1) }) {
                Box(modifier = Modifier.size(24.dp)) {
                    UpVoteArrow(color = if (voteState == -1) AppTokens.Colors.primary else AppTokens.Colors.outline, modifier = Modifier.matchParentSize().align(Alignment.Center))
                }
            }
        }
        Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
            AuthorInfo(post.author, post.timestamp)
            Text(post.title, style = MaterialTheme.typography.headlineSmall, color = AppTokens.Colors.onSurface)
            Text(post.body, style = MaterialTheme.typography.bodyLarge, color = AppTokens.Colors.onSurface.copy(alpha = 0.8f))
            Spacer(Modifier.height(AppTokens.Spacing.sm))
            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xl)) {
                InfoChip(text = "${post.commentCount} Comments")
                InfoChip(text = "Share")
            }
        }
    }
}

@Composable
fun ReplyCard(reply: Reply, modifier: Modifier = Modifier) {
    Row(
        modifier = modifier.fillMaxWidth().height(intrinsicSize = IntrinsicSize.Min),
        horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
    ) {
        Box(
            modifier = Modifier.fillMaxHeight().width(2.dp).background(
                color = reply.author.avatarColor.copy(alpha = 0.5f),
                shape = RoundedCornerShape(2.dp)
            )
        )
        Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
            AuthorInfo(reply.author, reply.timestamp)
            Text(reply.text, style = MaterialTheme.typography.bodyLarge, color = AppTokens.Colors.onSurface.copy(alpha = 0.9f))
            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md), verticalAlignment = Alignment.CenterVertically) {
                InfoChip(text = "${reply.votes} votes")
                InfoChip(text = "Reply")
            }
        }
    }
}

@Composable
fun AuthorInfo(author: Author, timestamp: String) {
    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
        Box(modifier = Modifier.size(24.dp).clip(CircleShape).background(author.avatarColor)) {
            Canvas(modifier = Modifier.matchParentSize()) {
                drawCircle(color = Color.Black.copy(alpha=0.2f), radius = size.minDimension/3)
            }
        }
        Text(author.name, style = MaterialTheme.typography.labelMedium, color = author.avatarColor, fontWeight = FontWeight.Bold)
        Text(timestamp, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.outline)
    }
}

@Composable
fun InfoChip(text: String) {
    Text(text, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.outline, fontWeight = FontWeight.Bold)
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFF101024)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}