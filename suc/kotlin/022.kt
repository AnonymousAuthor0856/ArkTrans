package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "022GanttCharten"
private const val UI_TYPE = "Productivity"
private const val STYLE_THEME = "Glassmorphic"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF38BDF8)
        val secondary = Color(0xFF6366F1)
        val tertiary = Color(0xFFA5B4FC)
        val background = Color(0xFFF1F5F9)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE2E8F0)
        val outline = Color(0xFFD1D5DB)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF1E1E1E)
        val onTertiary = Color(0xFF1E1E1E)
        val onBackground = Color(0xFF1E1E1E)
        val onSurface = Color(0xFF1E1E1E)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.16f)
    }
}

private val AppColorScheme = lightColorScheme(
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
    displayLarge = AppTokens.TypographyTokens.display,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
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

data class Task(val name: String, val progress: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val tasks = remember {
        listOf(
            Task("Design Phase", 0.8f),
            Task("Development", 0.5f),
            Task("Testing", 0.3f),
            Task("Documentation", 0.6f),
            Task("Deployment", 0.2f)
        )
    }
    var notificationsEnabled by remember { mutableStateOf(true) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Project Timeline", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.surface.copy(alpha = 0.8f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.surface.copy(alpha = 0.8f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text("Notifications", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                Switch(
                    checked = notificationsEnabled,
                    onCheckedChange = { notificationsEnabled = it },
                    colors = SwitchDefaults.colors(checkedThumbColor = AppTokens.Colors.primary)
                )
            }
            LazyColumn(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
                items(tasks) { task ->
                    Surface(
                        shape = AppTokens.Shapes.large,
                        tonalElevation = AppTokens.ElevationMapping.level1.elevation,
                        shadowElevation = AppTokens.ElevationMapping.level1.elevation,
                        modifier = Modifier.fillMaxWidth(),
                        color = AppTokens.Colors.surface.copy(alpha = 0.7f)
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(AppTokens.Spacing.md),
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                            Text(task.name, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary)
                            LinearProgressIndicator(
                                progress = { task.progress },
                                color = AppTokens.Colors.secondary,
                                trackColor = AppTokens.Colors.surfaceVariant,
                                modifier = Modifier.fillMaxWidth().height(8.dp)
                            )
                        }
                    }
                }
            }
            Button(
                onClick = {},
                shape = AppTokens.Shapes.large,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                modifier = Modifier.fillMaxWidth().height(52.dp)
            ) {
                Text("Add Task", style = MaterialTheme.typography.titleMedium)
            }
        }
    }


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

@Preview(showBackground = true, backgroundColor = 0xFFF1F5F9)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}