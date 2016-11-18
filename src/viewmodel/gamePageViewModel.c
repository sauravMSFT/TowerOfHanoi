#include <gamePageViewModel.h>
#include <GL/glut.h>
#include <stdlib.h>
#include <stack.h>
#include <window.h>
#include <disk.h>
#include <constants.h>
#include <ai.h>

void render_gamePage(void)
{
  glClear(GL_COLOR_BUFFER_BIT);
  for (int i = 0; i < 3; ++i)
    traverse(vm->game->poles[i], drawDisk);
  glutSwapBuffers();
}

GamePageViewModel *new_gamePageViewModel(int n)
{
  GamePageViewModel *gm = (GamePageViewModel *)malloc(sizeof(GamePageViewModel));
  gm->render = render_gamePage;
  gm->disks = n;
  gm->height = ((600.0 / n) < 80) ? 600.0 / (n) : 80;
  gm->game = new_Game(n, solve_ai, gm->height);
  gm->window = new_Window(0, 0, 810, 675);
  setupGame(gm);
  return gm;
}

void setupGame(GamePageViewModel *t)
{
  double i = 0;
  //Outer radius
  double or = 280;
  //y Coordinate
  double y = 50;
  //Color for the disk
  Color col;
  for (; i < t->disks; ++i)
  {
    col[0] = (rand() % 200) / 255.0;
    col[1] = (rand() % 200) / 255.0;
    col[2] = (rand() % 200) / 255.0;
    push(t->game->poles[Source], *(new_Disk(SourceX, y, or, t->height, col)));
    y += t->height;
    or -= (270 / t->disks);
  }
}