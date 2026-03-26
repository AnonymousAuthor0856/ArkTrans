
package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

object AppTokens {
    object Colors {
        val primary = Color(0xFFFF7B00)
        val secondary = Color(0xFFFFD166)
        val background = Color(0xFFFFF6E5)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFF0C1)
        val outline = Color(0xFFE0C080)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF3E2723)
        val onBackground = Color(0xFF3E2723)
        val onSurface = Color(0xFF3E2723)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.12f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline
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
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class ResultItem(val id: Int, val title: String)

@Composable
fun RootScreen() {
    val query = remember { mutableStateOf("") }
    val knob = remember { mutableStateOf(Offset(160f, 120f)) }
    val results = remember { List(6) { i -> ResultItem(i, "Result ${i + 1}") } }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier.fillMaxSize().padding(pad).padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            Text("Retro Filter Search", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.onBackground)
            TextField(
                value = query.value,
                onValueChange = { query.value = it },
                modifier = Modifier.fillMaxWidth(),
                placeholder = { Text("Search products", color = AppTokens.Colors.onSurface.copy(alpha = 0.4f)) },
                colors = TextFieldDefaults.colors(
                    focusedContainerColor = AppTokens.Colors.surface,
                    unfocusedContainerColor = AppTokens.Colors.surface,
                    focusedIndicatorColor = AppTokens.Colors.primary,
                    unfocusedIndicatorColor = AppTokens.Colors.outline
                ),
                shape = AppTokens.Shapes.medium
            )
            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                listOf("Popular", "New", "Discount", "Premium").forEach {
                    Button(
                        onClick = {},
                        shape = AppTokens.Shapes.small,
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary),
                        modifier = Modifier.height(36.dp)
                    ) {
                        Text(it, style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSecondary)
                    }
                }
            }
            Box(modifier = Modifier.fillMaxWidth().height(180.dp).background(AppTokens.Colors.surface, AppTokens.Shapes.large)) {
                Canvas(
                    modifier = Modifier.fillMaxSize().padding(16.dp).pointerInput(Unit) {
                        detectDragGestures { change, _ -> knob.value = change.position }
                    }
                ) {
                    drawRect(color = AppTokens.Colors.surfaceVariant)
                    drawCircle(brush = Brush.radialGradient(listOf(AppTokens.Colors.secondary, AppTokens.Colors.primary)), radius = 80f, center = Offset(size.width / 2, size.height / 2))
                    drawCircle(color = AppTokens.Colors.primary, radius = 16f, center = knob.value)
                }
            }
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                contentPadding = PaddingValues(bottom = 24.dp)
            ) {
                items(results) { item ->
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation)
                    ) {
                        Column(
                            modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                            Box(modifier = Modifier.size(96.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium))
                            Text(item.title, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                            Button(
                                onClick = {},
                                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary),
                                shape = AppTokens.Shapes.medium,
                                modifier = Modifier.fillMaxWidth()
                            ) {
                                Text("Add", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onPrimary)
                            }
                        }
                    }
                }
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

@Preview(showBackground = true, backgroundColor = 0xFFFFF6E5)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}