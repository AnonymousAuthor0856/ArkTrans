package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "078_CodeIDE_en"
private const val UI_TYPE = "Education Terminal"
private const val STYLE_THEME = "Retro Flat"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1E293B)
        val secondary = Color(0xFF0EA5E9)
        val tertiary = Color(0xFFFACC15)
        val background = Color(0xFF111827)
        val surface = Color(0xFF1E293B)
        val surfaceVariant = Color(0xFF334155)
        val outline = Color(0xFF475569)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF0B1220)
        val onBackground = Color(0xFFE2E8F0)
        val onSurface = Color(0xFFE2E8F0)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 36.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 1.dp, 0.1f)
        val level2 = ShadowSpec(3.dp, 4.dp, 2.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 6.dp, 3.dp, 0.16f)
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
    headlineMedium = AppTokens.TypographyTokens.headline,
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

data class CodeMarker(val id: Int, val name: String, val desc: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val markers = listOf(
        CodeMarker(1, "Main.kt", "Entry point for Compose app"),
        CodeMarker(2, "Utils.kt", "Helper functions"),
        CodeMarker(3, "Theme.kt", "Color & Typography setup"),
        CodeMarker(4, "Data.kt", "Repository and model classes")
    )
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text("CodeIDE Terminal", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onBackground)
                }
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .background(
                    Brush.verticalGradient(
                        listOf(AppTokens.Colors.primary.copy(alpha = 0.8f), AppTokens.Colors.surface.copy(alpha = 0.9f))
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Project Files", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onBackground)
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                contentPadding = PaddingValues(bottom = AppTokens.Spacing.xl)
            ) {
                items(markers.size) { i ->
                    val m = markers[i]
                    Card(
                        modifier = Modifier.fillMaxWidth(),
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant)
                    ) {
                        Row(
                            modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.md),
                            horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(32.dp)
                                    .background(AppTokens.Colors.secondary, AppTokens.Shapes.small),
                                contentAlignment = Alignment.Center
                            ) {
                                Text(m.id.toString(), color = AppTokens.Colors.onSecondary, style = MaterialTheme.typography.labelMedium)
                            }
                            Column {
                                Text(m.name, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                                Text(m.desc, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
                            }
                        }
                    }
                }
            }
            Text("Live Terminal", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onBackground)
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(240.dp)
                    .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium)
                    .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
                    .padding(AppTokens.Spacing.md)
            ) {
                Text("> println(\"Hello, Kotlin!\")", color = AppTokens.Colors.onSurface, style = MaterialTheme.typography.bodyMedium)
            }
            Button(
                onClick = {},
                modifier = Modifier.align(Alignment.CenterHorizontally).fillMaxWidth(0.6f).height(48.dp),
                shape = AppTokens.Shapes.large,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary)
            ) {
                Text("Run Code", style = MaterialTheme.typography.titleMedium)
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

@Preview(showBackground = true, backgroundColor = 0xFF111827)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
